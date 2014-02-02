require 'spec_helper'

describe User do
  it 'I can create a new user' do
    user = User.create(email: 'test@example.com', fname: 'John', lname: 'Doe')
    expect(user.id).to_not be_nil
  end

  it 'validates the required fields' do
    user = User.new(email: nil, fname: nil, lname: nil)
    user.errors[:email].should include('is required')
    user.errors[:fname].should include('is required')
    user.errors[:lname].should include('is required')
  end

  it 'assigns a unique referral code' do
    user = User.create!(email: 'test@example.com', fname: 'John', lname: 'Doe')
    expect(user.referral_code).to_not be_nil
  end

  # it 'sends a welcome email' do
  #   user = User.create(email: 'test@example.com', fname: 'John', lname: 'Doe')
  #   expect(Delayed::Job.count).to eq(1)
  # end

  context 'orders' do
    before(:all) do
      @user = User.create(email: 'test@example.com', fname: 'John', lname: 'Doe')
      @product = Product.create(name: 'Rails for Dummies')
    end

    before(:each) do
      @orders = []
      @packages = []

      10.times do
        order = Order.create(user: @user, @product: @product)
        package = Package.create(order: order, shipping_address: '123 Street Ave, New York, NY')
        @orders << order
        @packages << package
      end
    end

    it 'returns orders and packages for a user' do
      expect(@user.orders.size).to eq(10)
      expect(@user.packages.size).to eq(10)
    end

    context '#most_recent_package' do
      it 'returns the most recent package' do
        expect(@user.most_recent_package).to eq(@packages.last)
      end

      it 'the most recent package belongs to the last order' do
        expect(@user.most_recent_package.order).to eq(@orders.last)
      end
    end

    it 'the has_orders method indicates whether a user has any orders' do
      expect(@user.has_orders).to eq(true)
    end
  end
end
