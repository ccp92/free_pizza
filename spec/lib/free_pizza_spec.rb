require_relative '../../lib/free_pizza.rb'

RSpec.describe FreePizza do
  context 'With no orders' do
    describe 'No customers' do
      it 'returns an empty customer name array' do
        expect(FreePizza.convert(nil,nil,{})).to eql([])
      end
    end
  end

  context 'With one order' do
    context 'One customer' do
      let(:customer) { { 'Chris' => [1] } }
      let(:customer2) { { 'Bob' => [1] } }

      context 'With a qualifying spend' do
        it 'returns array of customer name' do
          expect(FreePizza.convert(nil, nil, customer)).to eql(['Chris'])
        end

        context 'With Bob' do
          it 'returns array of Bob' do
            expect(FreePizza.convert(nil, nil, customer2)).to eql(['Bob'])
          end
        end
      end

      context 'With a qualifying number of orders' do
        let(:customer) { { 'Chris' => [1, 3] } }
        let(:customer2) { { 'Bob' => [1, 4] } }

        it 'returns array of customer name' do
          expect(FreePizza.convert(1, 2, customer)).to eql(['Chris'])
        end

        context 'With Bob' do
          it 'returns an array of Bob' do
            expect(FreePizza.convert(1, 4, customer2)).to eql(['Bob'])
          end
        end
      end

      context 'Without a qualifying spend' do
        it 'returns an empty array' do
          expect(FreePizza.convert(nil, 2, customer)).to eql([])
        end
      end
    end

    context 'Two customers' do
      let(:customers) { { 'Chris' => [1], 'Ryan' => [2] } }
      let(:customers2) { { 'Bob' => [1], 'Dob' => [2] } }
      let(:customers3) { { 'Trent' => [3, 4, 5], 'Kent' => [1, 2]}}

      context 'One customer exceeds the minimum qualifying_orders' do
        it 'return an array with the qualifying customer name' do
          expect(FreePizza.convert(3, 3, customers3)).to eql(['Trent'])
        end
      end

      context 'Both customers exceed the minimum qualifying_orders' do
        it 'returns an array with both customer names' do
          expect(FreePizza.convert(2, 1, customers3)).to eql(['Trent', 'Kent'])
        end
      end

      context 'One customer with a qualifying spend' do
        it 'returns an array with the qualifying customer name' do
          expect(FreePizza.convert(nil, 2, customers)).to eql(['Ryan'])
        end

        context 'Using second customer list' do
          it 'returns an array with the qualifying customer name' do
            expect(FreePizza.convert(nil, 2, customers2)).to eql(['Dob'])
          end
        end
      end


      context 'No customers with a qualifying spend' do
        it 'returns an empty array' do
          expect(FreePizza.convert(nil, 3, customers)).to eql([])
        end
      end

      context 'Two customers with a qualifying spend' do
        it 'returns an array with all qualifying customer names' do
          expect(FreePizza.convert(nil, 0, customers)).to eql(['Chris', 'Ryan'])
        end
      end
    end
  end
end
