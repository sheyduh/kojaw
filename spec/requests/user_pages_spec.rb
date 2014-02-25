require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end

    it { should have_title('Directory') }
    it { should have_content('Directory') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
  end
  
  describe "delete links" do

        it { should_not have_link('delete') }

        describe "as an admin user" do
          let(:admin) { FactoryGirl.create(:admin) }
          before do
            sign_in admin
            visit users_path
          end

          it { should have_link('delete', href: user_path(User.first)) }
          it "should be able to delete another user" do
            expect do
              click_link('delete', match: :first)
            end.to change(User, :count).by(-1)
          end
          it { should_not have_link('delete', href: user_path(admin)) }
        end
      end
    end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end
  describe "signup" do

      before { visit signup_path }

      let(:submit) { "Create my account" }

      describe "with invalid information" do
        it "should not create a user" do
          expect { click_button submit }.not_to change(User, :count)
        end
      end

      describe "with valid information" do
        before do
          fill_in "Name",         with: "Example User"
          fill_in "Email",        with: "user@example.com"
          fill_in "Business Name",    with: new_biz
          fill_in "Address",          with: new_address
          fill_in "City",             with: new_city
          fill_in "Zipcode",          with: new_zipcode
          fill_in "Phone Number",     with: new_num
          fill_in "Business Hours",   with: new_hours
          fill_in "Other",            with: new_other
          fill_in "Password",     with: "foobar"
          fill_in "Confirmation", with: "foobar"
        end

        it "should create a user" do
          expect { click_button submit }.to change(User, :count).by(1)
        end
      end
    end
    describe "edit" do
      let(:user) { FactoryGirl.create(:user) }
      before { visit edit_user_path(user) }

      describe "page" do
        it { should have_content("Update your profile") }
        it { should have_title("Edit user") }
      end

      describe "with valid information" do
            let(:new_name)  { "New Name" }
            let(:new_email) { "new@example.com" }
            before do
              fill_in "Name",             with: new_name
              fill_in "Email",            with: new_email
              fill_in "Business Name",    with: new_biz
              fill_in "Address",          with: new_address
              fill_in "City",             with: new_city
              fill_in "Zipcode",          with: new_zipcode
              fill_in "Phone Number",     with: new_num
              fill_in "Business Hours",   with: new_hours
              fill_in "Other",            with: new_other
              fill_in "Password",         with: user.password
              fill_in "Confirm Password", with: user.password
              click_button "Save changes"
            end
            it { should have_title(new_name) }
                  it { should have_selector('div.alert.alert-success') }
                  it { should have_link('Sign out', href: signout_path) }
                  specify { expect(user.reload.name).to  eq new_name }
                  specify { expect(user.reload.email).to eq new_email }
                end
      describe "forbidden attributes" do
                  let(:params) do
                    { user: { admin: true, password: user.password,
                              password_confirmation: user.password } }
                  end
                  
                  before do
                    sign_in user, no_capybara: true
                    patch user_path(user), params
                  end
                  
                  specify { expect(user.reload).not_to be_admin }
                end
    end
  end