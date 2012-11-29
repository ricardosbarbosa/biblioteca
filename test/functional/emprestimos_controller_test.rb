require 'test_helper'

class EmprestimosControllerTest < ActionController::TestCase
  setup do
    @emprestimo = emprestimos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:emprestimos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create emprestimo" do
    assert_difference('Emprestimo.count') do
      post :create, emprestimo: { data_de_devolucao: @emprestimo.data_de_devolucao, data_de_emprestimo: @emprestimo.data_de_emprestimo }
    end

    assert_redirected_to emprestimo_path(assigns(:emprestimo))
  end

  test "should show emprestimo" do
    get :show, id: @emprestimo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @emprestimo
    assert_response :success
  end

  test "should update emprestimo" do
    put :update, id: @emprestimo, emprestimo: { data_de_devolucao: @emprestimo.data_de_devolucao, data_de_emprestimo: @emprestimo.data_de_emprestimo }
    assert_redirected_to emprestimo_path(assigns(:emprestimo))
  end

  test "should destroy emprestimo" do
    assert_difference('Emprestimo.count', -1) do
      delete :destroy, id: @emprestimo
    end

    assert_redirected_to emprestimos_path
  end
end
