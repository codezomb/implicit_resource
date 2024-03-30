require "test_helper"
require "json"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "update action updates the article" do
    put article_url(articles(:implicit_resource)), headers: { "Accept" => "application/json" }, params: { article: { title: "Updated Title" } }

    assert_equal "Updated Title", articles(:implicit_resource).reload.title
    assert_response :no_content
  end

  test "create action returns a new article" do
    post articles_url, headers: { "Accept" => "application/json" }, params: { article: { title: "Article #3", body: "Body #3" } }
    json_response = JSON.parse(@response.body)

    assert_equal "Article #3", json_response["title"]
    assert_equal "Body #3", json_response["body"]
    assert_equal 3, Article.count
    assert_response :created
  end

  test "destroy action destroyes the article" do
    delete article_url(articles(:implicit_resource)), headers: { "Accept" => "application/json" }

    assert_equal 1, Article.count
    assert_response :no_content
  end

  test "edit action returns the correct article" do
    get edit_article_url(articles(:implicit_resource)), headers: { "Accept" => "application/json" }
    json_response = JSON.parse(@response.body)

    assert_equal articles(:implicit_resource).title, json_response["title"]
    assert_equal articles(:implicit_resource).body, json_response["body"]
    assert_response :success
  end

  test "show action returns the correct article" do
    get article_url(articles(:implicit_resource)), headers: { "Accept" => "application/json" }
    json_response = JSON.parse(@response.body)

    assert_equal articles(:implicit_resource).title, json_response["title"]
    assert_equal articles(:implicit_resource).body, json_response["body"]
    assert_response :success
  end

  test "new action returns a new article template" do
    get new_article_url, headers: { "Accept" => "application/json" }
    json_response = JSON.parse(@response.body)

    assert_nil json_response["title"]
    assert_nil json_response["body"]
    assert_response :success
  end

  test "index action returns a list of articles" do
    get articles_url, headers: { "Accept" => "application/json" }
    json_response = JSON.parse(@response.body)

    assert_equal Article.count, json_response.length
    assert_response :success
  end
end
