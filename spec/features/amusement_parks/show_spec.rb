require "rails_helper"

RSpec.describe "/amusement_parks/:id, amusement_parks show page" do
  before(:each) do
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @universal = AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)

    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

    @jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)
    @toys = @universal.rides.create!(name: 'Toy Story', thrill_rating: 3, open: false)

    @suzie = Mechanic.create!(name: 'Suzie Smalls', years_experience: 2)
    @kara = Mechanic.create!(name: 'Kara Smith', years_experience: 11)
    @bob = Mechanic.create!(name: 'Bobby Brown', years_experience: 27)

    @ride_mech_1 = RideMechanic.create!(ride_id: @hurler.id, mechanic_id: @suzie.id)
    @ride_mech_2 = RideMechanic.create!(ride_id: @ferris.id, mechanic_id: @suzie.id)

    @ride_mech_3 = RideMechanic.create!(ride_id: @ferris.id, mechanic_id: @kara.id)
    @ride_mech_4 = RideMechanic.create!(ride_id: @scrambler.id, mechanic_id: @kara.id)
    @ride_mech_5 = RideMechanic.create!(ride_id: @toys.id, mechanic_id: @kara.id)

    @ride_mech_6 = RideMechanic.create!(ride_id: @toys.id, mechanic_id: @bob.id)
    @ride_mech_7 = RideMechanic.create!(ride_id: @jaws.id, mechanic_id: @bob.id)
  end

  describe "as a visitor on amusement_parks show page" do
    it "shows name, price of admission, all unique mechnanics working on rides" do
      visit "/amusement_parks/#{@universal.id}"

      expect(page).to have_content(@universal.name)
      expect(page).to_not have_content(@six_flags.name)
      expect(page).to have_content("Price of Admission: #{@universal.admission_cost}")
      expect(page).to have_content("Mechanics Currently Working on Rides:")

      within "#mechanics-#{@universal.id}" do
        expect(page).to have_content(@kara.name, count: 1)
        expect(page).to have_content(@bob.name, count: 1) #or expect(page).to have_content(@bob.name).once
        expect(page).to_not have_content(@suzie.name)
      end
    end
  end
end