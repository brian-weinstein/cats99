require "application_system_test_case"

class CatRentalRequestsTest < ApplicationSystemTestCase
  setup do
    @cat_rental_request = cat_rental_requests(:one)
  end

  test "visiting the index" do
    visit cat_rental_requests_url
    assert_selector "h1", text: "Cat rental requests"
  end

  test "should create cat rental request" do
    visit cat_rental_requests_url
    click_on "New cat rental request"

    fill_in "Cat", with: @cat_rental_request.cat_id
    fill_in "End date", with: @cat_rental_request.end_date
    fill_in "Start date", with: @cat_rental_request.start_date
    fill_in "Status", with: @cat_rental_request.status
    click_on "Create Cat rental request"

    assert_text "Cat rental request was successfully created"
    click_on "Back"
  end

  test "should update Cat rental request" do
    visit cat_rental_request_url(@cat_rental_request)
    click_on "Edit this cat rental request", match: :first

    fill_in "Cat", with: @cat_rental_request.cat_id
    fill_in "End date", with: @cat_rental_request.end_date
    fill_in "Start date", with: @cat_rental_request.start_date
    fill_in "Status", with: @cat_rental_request.status
    click_on "Update Cat rental request"

    assert_text "Cat rental request was successfully updated"
    click_on "Back"
  end

  test "should destroy Cat rental request" do
    visit cat_rental_request_url(@cat_rental_request)
    click_on "Destroy this cat rental request", match: :first

    assert_text "Cat rental request was successfully destroyed"
  end
end
