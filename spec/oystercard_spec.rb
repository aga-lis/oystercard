require 'oystercard'
describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:station){double :station }

  it 'has a balance of zero' do
    expect(oystercard.balance).to eq(0)
  end
  it 'has no journey history' do
    expect(oystercard.journeys).to eq []
  end

  describe '#top_up' do
    it{ is_expected.to respond_to(:top_up).with(1).argument }
    #it{ is_expected.to respond_to(:deduct).with(1).argument }

    it 'tops up by amount given' do
      expect{ oystercard.top_up 1 }.to change{ oystercard.balance }.by 1
      end
    it 'raises an error when over max amount' do
      card_limit = Oystercard::CARD_LIMIT
      oystercard.top_up(card_limit)
       expect{ oystercard.top_up 1 }.to raise_error "Oystercard maximum balance of #{Oystercard::CARD_LIMIT} exceeded"
    end
    it 'deducts fare from my card' do
      oystercard.top_up(5)
      oystercard.touch_in(:station)
      oystercard.send(:deduct, 5)
      expect { oystercard.touch_out(:station) }.to change{ oystercard.balance }.by -1
    end
  end

  describe '#journey' do
    it 'is initially not in a journey' do
      expect(oystercard).not_to be_in_journey
    end
    it 'can touch in' do
      oystercard.top_up(5)
      oystercard.touch_in(:station)
      expect(oystercard).to be_in_journey
    end
    it 'should remember where I started my journey' do
      oystercard.top_up(5)
      oystercard.touch_in(:station)
      expect(oystercard.entry_station[:entry_station]).to eq :station
    end
    it 'can touch out' do
      #expect { oystercard.touch_out }.to change{ oystercard.balance }.by -1
      oystercard.top_up(10)
      oystercard.touch_in(:station)
      oystercard.touch_out(:station)
      expect(oystercard).not_to be_in_journey
    end
    it 'will not touch in if below minimum balance' do
      expect{ subject.touch_in(:station) }.to raise_error "Insufficient balance to touch in"
    end

    it 'will make the value of entry_station nil when touched out' do
      oystercard.top_up(5)
      oystercard.touch_in(:station)
      oystercard.touch_out(:station)
      expect(oystercard.entry_station).to eq nil
    end
#    it 'raises an error if card does not have minimum balance' do
#      card_min_balance = Oystercard::CARD_LIMIT
#      oystercard.touch_in
#      expect{ oystercard.touch_in}.to raise_error 'Cannot touch in: minimum balance not met'
#    end
  end
end
