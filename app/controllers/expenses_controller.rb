class ExpensesController < ApplicationController
  before_action :set_group, only: %i[index new edit create update destroy]

  def index
    @group = Group.find(params[:group_id])
    @expenses = @group.expenses.order(created_at: :desc)
  end

  def new
    @expense = Expense.new
  end

  def create
    @author = current_user
    @expense = @author.expenses.new expense_params
    if @expense.save
      @group_expense = GroupExpense.create(group: @group, expense: @expense)
      redirect_to group_expenses_path(@group.id), notice: 'Transaction was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @groups = Group.all.order(name: :asc)
    @group = Group.find(params[:group_id])
    @expense = @group.expenses.find(params[:id])
  end

  def update
    @group = Group.find(params[:group_id])
    @category = Group.find((params[:expense][:category])[1])
    @expense = @group.expenses.find(params[:id])
    @group_expense = GroupExpense.where(group: @group, expense: @expense)
    if @expense.update(expense_params)
      @group_expense.update(group: @category, expense: @expense)
      redirect_to group_expenses_url(@group), notice: 'Transaction was successfully updated.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @group = Group.find(params[:group_id])
    if @expense.destroy
      flash[:success] = 'Transaction was successfully removed.'
    else
      flash[:error] = 'Transaction could not be removed'
    end
    redirect_to group_expenses_url(@group)
  end

  def set_group
    @group = current_user.groups.find(params[:group_id])
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount, :category)
  end
end
