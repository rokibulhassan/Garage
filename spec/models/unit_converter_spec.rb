require 'spec_helper'

describe UnitConverter do
  describe "Power" do
    it "should convert horsepower EU to kilowatts" do
      converter = UnitConverter.new(96, :horsepower_eu)
      converter.to(:kilowatt).should == 70.66
    end

    it "should convert horsepower US to kilowatts" do
      converter = UnitConverter.new(96, :horsepower_us)
      converter.to(:kilowatt).should == 71.62
    end

    it "should convert horsepower US to kilowatts" do
      converter = UnitConverter.new(96, :horsepower_uk)
      converter.to(:kilowatt).should == 71.62
    end
  end


  describe "Torque" do
    it "should convert foot pounds to newton metres" do
      converter = UnitConverter.new(60, :foot_pounds)
      converter.to(:newton_metre).should == 81.36
    end
  end



  describe "Speed" do
    it "should convert miles per hour to kilometres per hour" do
      converter = UnitConverter.new(100, :mile_per_hour)
      converter.to(:kilometre_per_hour).should == 160.9
    end
  end


  describe "Volume" do
    it "should convert imperial gallons to litres" do
      converter = UnitConverter.new(8, :imperial_gallon)
      converter.to(:litre).should == 36.37
    end

    it "should convert us gallons to litres" do
       converter = UnitConverter.new(8, :us_gallon)
       converter.to(:litre).should == 30.28
    end

    it "should convert cubic inches to cubic centimetres" do
      converter = UnitConverter.new(10, :cubic_inch)
      converter.to(:cubic_centimetre).should == 163.87
    end
  end


  describe "Weight" do
    it "should convert pounds in kilograms" do
      converter = UnitConverter.new(100, :pound)
      converter.to(:kilogram).should == 45.36
    end
  end


  describe "Fuel consumption" do
    it "should convert miles per US gallon to litres per 100 kilometres" do
      converter = UnitConverter.new(30, :miles_per_us_gallon)
      converter.to(:litres_per_100_kilometres).should == 7.84
    end

    it "should convert miles per imperial gallon to litres per 100 kilometres" do
      converter = UnitConverter.new(30, :miles_per_imperial_gallon)
      converter.to(:litres_per_100_kilometres).should == 9.42
    end
  end


  describe "Distance" do
    it "should convert miles to kilometres" do
      converter = UnitConverter.new(100, :mile)
      converter.to(:kilometre).should == 160.9
    end

    it "should convert feet to metres" do
      converter = UnitConverter.new(100, :foot)
      converter.to(:metre).should == 30.48
    end
  end


  describe "Length" do
    it "should convert inches in millimetres" do
      converter = UnitConverter.new(100, :inch)
      converter.to(:millimetre).should == 2540
    end
  end


  describe "Pressure" do
    it "should convert pounds per square inch to bars" do
      converter = UnitConverter.new(100, :pound_per_square_inch)
      converter.to(:bar).should == 6.9
    end
  end


  describe "Gaz emission" do
    it "should convert grams per mile to grams per kimometre" do
      converter = UnitConverter.new(100, :gram_per_mile)
      converter.to(:gram_per_kilometre).should == 160.9
    end
  end


  describe "Forbidden conversions" do
    it "should not convert unknown units" do
      converter = UnitConverter.new(60, :some_unknown_unit)
      expect { converter.to(:kilowatt) }.to raise_error(UnitConverter::UnknownConversion)
    end


    it "should not convert foot pounds to kilowatts" do
      converter = UnitConverter.new(60, :foot_pounds)
      expect { converter.to(:kilowatt) }.to raise_error(UnitConverter::UnknownConversion)
    end
  end
end
