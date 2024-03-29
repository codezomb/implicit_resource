require "test_helper"
require "json"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.create!(title: "Article #1", body: "Body #1")
  end

  test "index action returns a list of articles" do
    get articles_url, headers: { "Accept" => "application/json" }
    assert_response :success

    json_response = JSON.parse(@response.body)
    assert_equal 1, json_response.length
    assert_equal @article.title, json_response[0]["title"]
    assert_equal @article.body, json_response[0]["body"]
  end

  test "show action returns the correct article" do
    get article_url(@article), headers: { "Accept" => "application/json" }
    assert_response :success

    json_response = JSON.parse(@response.body)
    assert_equal @article.title, json_response["title"]
    assert_equal @article.body, json_response["body"]
  end

  test "edit action returns the correct article" do
    get edit_article_url(@article), headers: { "Accept" => "application/json" }
    assert_response :success

    json_response = JSON.parse(@response.body)
    assert_equal @article.title, json_response["title"]
    assert_equal @article.body, json_response["body"]
  end

  test "new action returns a new article template" do
    get new_article_url, headers: { "Accept" => "application/json" }
    assert_response :success

    json_response = JSON.parse(@response.body)
    assert_nil json_response["title"]
    assert_nil json_response["body"]
  end

  test "create action returns a new article" do
    post articles_url, headers: { "Accept" => "application/json" },
      params: { article: { title: "Article #2", body: "Body #2" } }

    assert_response :created

    json_response = JSON.parse(@response.body)
    assert_equal "Article #2", json_response["title"]
    assert_equal "Body #2", json_response["body"]
  end

  test "update action updates the article" do
    put article_url(@article), headers: { "Accept" => "application/json" },
      params: { article: { title: "Article Updated" } }

    assert_response :no_content

    assert_equal "Article Updated", @article.reload.title
  end

  test "destroy action destroyes the article" do
    delete article_url(@article), headers: { "Accept" => "application/json" }

    assert_response :no_content

    assert_equal 0, Article.count
  end
end
