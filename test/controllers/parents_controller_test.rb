require 'test_helper'

class ParentsControllerTest < ActionController::TestCase
  setup do
    @parent = parents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test 'should create two different parents' do
    post :create, params: { parent: { name: 'Parent A' }}, as: :json
    post :create, params: { parent: { name: 'Parent B' }}, as: :json

    assert_not_nil Parent.find_by_name 'Parent A'
    assert_equal 1, Parent.where(name: 'Parent A').count
    assert_not_nil Parent.find_by_name 'Parent B'
  end

  test "should create parent" do
    assert_difference('Parent.count') do
      post :create, params: { parent: { name: 'New Parent' } }
    end

    assert_response 201
  end

  test "should create parent with children" do
    assert_difference('Child.count', 1) do
      post :create, params: {
          parent: {
              name: 'New Parent',
              children_attributes: [
                  { name: 'New Child'}
              ]
          }
      }
      assert_response 201
    end

  end

  test "should show parent" do
    get :show, params: {id: @parent.id}
    assert_response :success
  end

  test "should update parent" do
    patch :update, params: { id: @parent.id, parent: { name: @parent.name } }, as: :json
    assert_response 200
  end

  test "should update parent creating a child" do
    parent = parents(:with_child)
    assert_no_difference('parent.reload.children.count') do
      patch :update, params: {id: parent.id, parent: {
          name: 'Updated Name',
          children: { name: 'Ignore Me'},
          children_attributes: [
              { name: 'New Child' },
              { id: children(:also_has_parent).id, name: 'Updated'},
              { id: children(:third_child).id, _destroy: 1}
          ]
      }}, as: :json
      assert_response 200
    end
  end

  test "should update parent creating a second child" do
    assert_difference('Child.count', 1) do
      patch :update, params: {id: @parent.id, parent: {
          name: 'Updated Name',
          children_attributes: [
              { name: 'New Child' }
          ]
      }}, as: :json
      assert_response 200
    end
  end

  test "should destroy parent" do
    assert_difference('Parent.count', -1) do
      delete :destroy, params: {id: @parent.id}
    end

    assert_response 204
  end
end
