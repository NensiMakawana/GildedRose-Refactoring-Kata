require File.join(File.dirname(__FILE__), 'gilded_rose')
require 'byebug'
describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context 'Other Item' do
      it "decreases quality and sell in by 1" do
        items = [Item.new("+5 Dexterity Vest", 10, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "+5 Dexterity Vest, 9, 19"
      end

      it "quantity never recahed less than 0" do
        items = [Item.new("+5 Dexterity Vest", 10, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "+5 Dexterity Vest, 9, 0"
      end
    end

    context 'Aged Brie' do
      it "quantity increase by 1 when sell in not passed" do
        items = [Item.new("Aged Brie", 2, 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Aged Brie, 1, 1"
      end

      it "quantity increase by 2 when sell in passed" do
        items = [Item.new("Aged Brie", 0, 2)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Aged Brie, -1, 4"
      end

      it "quantity never reached up to 50" do
        items = [Item.new("Aged Brie", 2, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Aged Brie, 1, 50"
      end
    end

    context 'Sulfuras, Hand of Ragnaros' do
      it "quantity never decreases" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Sulfuras, Hand of Ragnaros, 0, 80"
      end

      it "sell in never decreases" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", -1, 80)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Sulfuras, Hand of Ragnaros, -1, 80"
      end
    end

    context 'Backstage passes to a TAFKAL80ETC concert' do
      it 'quality increase by 3 when sell in value less than 6 ' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 3, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 2, 23"
      end

      it 'quality increase by 2 when sell in value less than 11' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 48)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 5, 50"
      end

      it 'quality increase by 1 when sell in value grater than 11 ' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 20)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 19, 21"
      end

      it "quantity never recahed more than 50" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 20, 50)]
        GildedRose.new(items).update_quality()
        expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 19, 50"
      end
    end
  end
end
