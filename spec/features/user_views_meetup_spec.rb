require 'spec_helper'

feature "user views meetup" do
  let(:meetup) do
    Meetup.create(
      name: 'Real Party',
      location: 'Real Bar',
      creator: 'real-person',
      description: 'Definitely not fake'
    )
  end
  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end
  let(:user2) do
    User.create(
      provider: "github",
      uid: "2",
      username: "actual-person",
      email: "actual@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  scenario "meetup information shows on meetup page" do
    meetup
    visit '/'
    click_on meetup.name

    expect(page).to have_content(meetup.location)
    expect(page).to have_content(meetup.creator)
    expect(page).to have_content(meetup.description)
  end

  scenario "meetup attendees are shown with avatars" do
    user2
    meetup
    Appearance.create(user_id: user2.id, meetup_id: meetup.id)
    visit '/'
    click_on meetup.name

    expect(page).to have_content(user2.username)
    expect(page).to have_selector("img[src='https://avatars2.githubusercontent.com/u/174825?v=3&s=400']")
  end

  scenario "signed in user can join meetup" do
    meetup
    visit '/'
    sign_in_as user
    click_on meetup.name
    click_on "Click Here to Join Meetup"

    expect(page).to have_content(user.username)
  end

  scenario "user not signed in cannot join meetup" do
    meetup
    visit "/meetups/#{meetup.id}"
    click_on "Click Here to Join Meetup"

    expect(page).to have_content('Please sign in to attend Meetup')
  end

end
