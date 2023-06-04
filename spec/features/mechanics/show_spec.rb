require "rails_helper"

RSpec.describe "/mechanics/:id, mechanics show page" do
  before(:each) do
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @universal = AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)

    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

    @jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)

    @suzie = Mechanic.create!(name: 'Suzie Smalls', years_experience: 2)
    @kara = Mechanic.create!(name: 'Kara Smith', years_experience: 11)

    @ride_mech_1 = RideMechanic.create!(ride_id: @hurler.id, mechanic_id: @suzie.id)
    @ride_mech_2 = RideMechanic.create!(ride_id: @ferris.id, mechanic_id: @suzie.id)

    @ride_mech_3 = RideMechanic.create!(ride_id: @ferris.id, mechanic_id: @kara.id)
    @ride_mech_4 = RideMechanic.create!(ride_id: @scrambler.id, mechanic_id: @kara.id)
  end

  describe "as a user, on the show page - US1" do
    it "displays name, yrs experience, and names of rides worked on" do
      visit "/mechanics/#{@suzie.id}/"

      expect(page).to have_content("Name: #{@suzie.name}")
      expect(page).to_not have_content("Name: #{@kara.name}")
      expect(page).to have_content("Yrs Experience: #{@suzie.years_experience}")
      expect(page).to have_content("Rides:")

      within "#rides-#{@suzie.id}" do
        expect(page).to have_content(@ride_mech_1)
        expect(page).to have_content(@ride_mech_2)
        expect(page).to_not have_content(@ride_mech_4)
      end
    end
  end
end