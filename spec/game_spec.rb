# frozen_string_literal: true

require 'game'
require_relative './game_helpers'

describe Game do
  describe '#bowl' do
    context 'when less than 10 pins are knocked down in a single frame' do
      context 'when given 4' do
        it 'returns 4' do
          expect(subject.bowl(4)).to eq(4)
        end
      end

      context 'when given 4 then 2' do
        it 'returns 6' do
          subject.bowl(4)
          expect(subject.bowl(2)).to eq(6)
        end
      end
    end

    context 'when a strike occurs' do
      context 'when given 10' do
        it 'returns 10' do
          expect(subject.bowl(10)).to eq(10)
        end
      end

      context 'when given 10 then 3' do
        it 'returns 16' do
          subject.bowl(10)
          expect(subject.bowl(3)).to eq(16)
        end
      end

      context 'when given 10 then 3 then 6' do
        it 'returns 28' do
          subject.bowl(10)
          subject.bowl(3)
          expect(subject.bowl(6)).to eq(28)
        end
      end

      context 'when given 10 then 3 then 6 then 4' do
        it 'returns 32' do
          subject.bowl(10)
          subject.bowl(3)
          subject.bowl(6)
          expect(subject.bowl(4)).to eq(32)
        end
      end

      context 'when three strikes occur in a row' do
        it 'returns 60' do
          subject.bowl(10)
          subject.bowl(10)
          expect(subject.bowl(10)).to eq(60)
        end
      end
    end

    context 'when a spare occurs' do
      context 'when given 7' do
        it 'returns 7' do
          expect(subject.bowl(7)).to eq(7)
        end
      end

      context 'when given 7 then 3' do
        it 'returns 10' do
          subject.bowl(7)
          expect(subject.bowl(3)).to eq(10)
        end
      end

      context 'when given 7 then 3 then 4' do
        it 'returns 18' do
          subject.bowl(7)
          subject.bowl(3)
          expect(subject.bowl(4)).to eq(18)
        end
      end

      context 'when given 7 then 3 then 4 then 2' do
        it 'returns 20' do
          subject.bowl(7)
          subject.bowl(3)
          subject.bowl(4)
          expect(subject.bowl(2)).to eq(20)
        end
      end
    end

    context 'in the 10th frame' do
      context 'when the player does not make a strike or a spare' do
        it 'returns 119' do
          bowl_until_last_frame
          subject.bowl(2)
          expect(subject.bowl(4)).to eq(119)
        end

        it 'the player does not get any bonus rolls' do
          bowl_until_last_frame
          subject.bowl(2)
          subject.bowl(4)
          expect(subject.bowl(4)).to eq(119)
        end
      end

      context 'when the player makes a spare' do
        it 'returns 133' do
          bowl_until_last_frame
          subject.bowl(2)
          subject.bowl(8)
          expect(subject.bowl(6)).to eq(133)
        end

        it 'the player only gets one bonus roll' do
          bowl_until_last_frame
          subject.bowl(2)
          subject.bowl(8)
          subject.bowl(6)
          expect(subject.bowl(6)).to eq(133)
        end
      end

      context 'when the player makes a strike' do
        it 'returns 137' do
          bowl_until_last_frame
          subject.bowl(10)
          subject.bowl(8)
          expect(subject.bowl(2)).to eq(145)
        end

        it 'the player only gets 2 bonus rolls' do
          bowl_until_last_frame
          subject.bowl(10)
          subject.bowl(8)
          subject.bowl(2)
          expect(subject.bowl(2)).to eq(145)
        end
      end
    end

    context 'when the player bowls a perfect game' do
      it 'returns 300' do
        expect(bowl_perfect_game).to eq(300)
      end
    end

    context 'when the player bowls a gutter game' do
      it 'returns 0' do
        expect(bowl_gutter_game).to eq(0)
      end
    end
  end
end
