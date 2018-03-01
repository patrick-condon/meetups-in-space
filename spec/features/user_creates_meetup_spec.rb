require 'spec_helper'

feature "user creates meetup" do
  let(:name) { "Real Party" }
  let(:location) { "Real Bar" }
  let(:description) { "Definitely not fake" }
  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  scenario "signed in user successfully creates meetup" do
    visit "/"
    sign_in_as user
    click_on "Create New Meetup"

    fill_in "Name", with: name
    fill_in "Location", with: location
    fill_in "description", with: description
    click_on "Submit"

    expect(page).to have_content('Congratulations! You Created a Meetup in Space')
  end

  scenario "creating new meetup takes you to show page" do
    visit "/"
    sign_in_as user
    click_on "Create New Meetup"

    fill_in "Name", with: name
    fill_in "Location", with: location
    fill_in "Description", with: description
    click_on "Submit"

    expect(page).to have_content(name)
    expect(page).to have_content(location)
    expect(page).to have_content(user.username)
    expect(page).to have_content(description)
    expect(page).to have_content('Attendees')
  end

  scenario "user cannot submit blank fields" do
    visit "/"
    sign_in_as user
    click_on "Create New Meetup"
    click_on "Submit"

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Location can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario "form fields retain information on incomplete submissions" do
    visit "/"
    sign_in_as user
    click_on "Create New Meetup"
    fill_in "Name", with: name
    fill_in "Location", with: location
    click_on "Submit"

    expect(page).to have_selector("input[value='Real Party']")
    expect(page).to have_selector("input[value='Real Bar']")
    expect(page).to have_content("Description can't be blank")
  end

  scenario "user not signed in cannot create meetup" do
    visit "/meetups/new"

    fill_in "Name", with: name
    fill_in "Location", with: location
    fill_in "Description", with: description
    click_on "Submit"

    expect(page).to have_content('Please sign in to create a Meetup')
  end

end
