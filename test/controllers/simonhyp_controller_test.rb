require 'test_helper'
require "selenium-webdriver"

class SimonhypControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get index_path
    assert_response :success
  end

  test "functional" do
    driver = Selenium::WebDriver.for :firefox
    driver.navigate.to "http://localhost:3000"

    form = driver.find_element id: 'input_form'
    field = driver.find_element id: 'input_field'
    status = driver.find_element id: 'result_status'
    content = driver.find_element id: 'result_content'

    form.submit
    sleep 1
    assert_not_empty status.text.to_s
    assert !content.displayed?

    field.send_keys 'some_str'
    form.submit
    sleep 1
    assert_not_empty status.to_s
    assert !content.displayed?

    field.clear
    field.send_keys '-1'
    form.submit
    sleep 1
    assert_not_empty status.to_s
    assert !content.displayed?

    field.clear
    field.send_keys '0'
    form.submit
    sleep 1
    assert_not_empty status.to_s
    assert !content.displayed?
    count = driver.find_elements(class: 'content-row').count
    assert_equal count, 0

    field.clear
    field.send_keys '3'
    form.submit
    sleep 1
    assert_not_empty status.to_s
    assert content.displayed?
    count = driver.find_elements(class: 'content-row').count
    assert_equal count, 1

    field.clear
    field.send_keys '10'
    form.submit
    sleep 1
    assert_not_empty status.to_s
    assert content.displayed?
    count = driver.find_elements(class: 'content-row').count
    assert_equal count, 4

    field.clear
    field.send_keys '180'
    form.submit
    sleep 1
    assert_not_empty status.to_s
    assert content.displayed?
    count = driver.find_elements(class: 'content-row').count
    assert_equal count, 4

    driver.quit
  end
end
