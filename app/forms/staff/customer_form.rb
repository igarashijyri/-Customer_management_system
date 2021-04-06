class Staff::CustomeForm
  include ActiveModel::Model

  attr_accessor :customer
  delegate :persited?, to: :customer

  def initialize
    @customer = customer
    @customer ||= Customer.new(gender: "male")
    @customer.build_home_address unless @customer.home_address
    @customer.build_work_address unless @customer.work_address 
  end