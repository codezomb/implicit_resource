require "implicit_resource"
require "test_helper"

class ImplicitResourceTest < ActiveSupport::TestCase
  setup do
    @names_spaced_controller = Admin::ArticlesController.new
    @controller = ArticlesController.new
  end

  test "it has a version number" do
    assert ImplicitResource::VERSION
  end

  test "namespace returns correct namespace" do
    assert_equal [:admin], @names_spaced_controller.send(:namespace)
  end

  test "model_klass returns correct class" do
    assert_equal Article, @names_spaced_controller.send(:model_klass)
    assert_equal Article, @controller.send(:model_klass)
  end
end
