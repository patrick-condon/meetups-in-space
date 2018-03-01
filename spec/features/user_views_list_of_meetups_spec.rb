require 'spec_helper'

feature "user visits meetups page" do
  let(:meetup) do
    Meetup.create(
      name: 'Real Party',
      location: 'Real Bar',
      creator: 'real-person',
      description: 'Definitely not fake'
    )
  end
  let(:meetup2) do
    Meetup.create(
      name: 'A Real Party',
      location: 'Real Bar',
      creator: 'real-person',
      description: 'Definitely not fake'
    )
  end


  scenario "meetup shows on page" do
    meetup
    visit '/meetups'

    expect(page).to have_content "Real Party"
  end

  scenario "meetups show alphabetically on page" do
    meetup
    meetup2
    visit '/'

    expect(page.find_by_id("meetups-list").first('li')).to have_content(meetup2.name)
  end

  scenario "clicking title leads to event page with information" do
    meetup
    visit '/meetups'
    click_on 'Real Party'

    expect(page).to have_content('Real Bar')
    expect(page).to have_content('real-person')
    expect(page).to have_content('Definitely not fake')
  end

end
