require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }

  it 'has a balance of zero' do
    expect(oystercard.balance).to eq(0)
  end

  describe '#top_up' do
    it{ is_expected.to respond_to(:top_up).with(1).argument }
    it{ is_expected.to respond_to(:deduct).with(1).argument }

    it 'tops up by amount given' do
      expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
      end
    it 'raises an error when over max amount' do
      card_limit = Oystercard::CARD_LIMIT
      oystercard.top_up(card_limit)
       expect{ oystercard.top_up 1 }.to raise_error 'Oystercard maximum balance of £90 exceeded'
    end
    it 'deducts fare from my card' do
      expect{ oystercard.deduct 1 }.to change{ oystercard.balance }.by -1
    end
  end

    describe '#in_journey' do
      it 'is initially not in a journey' do
        expect(oystercard).not_to be_in_journey
      end
      it 'can touch in' do
        oystercard.touch_in
        expect(oystercard).to be_in_journey
      end
      it 'can touch out' do
        oystercard.touch_out
        expect(oystercard).not_to be_in_journey
      end
    end
end
