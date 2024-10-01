defmodule ExXirrTest do
  use ExUnit.Case, async: true
  doctest ExXirr

  describe "xirr/2" do
    test "positive and negative flow in the same day" do
      d = [{2014, 04, 15}, {2014, 04, 15}, {2014, 10, 19}]
      v = [-10000.0, 10000.0, 500.0]

      assert ExXirr.xirr(d, v) ==
               {:error, "Values should have at least one positive or negative value."}
    end

    test "impossible returns on investments" do
      d = [{2015, 11, 1}, {2015, 10, 1}, {2015, 6, 1}]
      v = [-800_000, -2_200_000, 1_000_000]
      assert ExXirr.xirr(d, v) == {:ok, 21.118359}
    end

    test "bad investment" do
      d = [{1985, 1, 1}, {1990, 1, 1}, {1995, 1, 1}]
      v = [1000, -600, -200]
      assert ExXirr.xirr(d, v) == {:ok, -0.034592}
    end

    test "repeated cashflow" do
      v = [1000.0, 2000.0, -2000.0, -4000.0]
      d = [{2011, 12, 07}, {2011, 12, 07}, {2013, 05, 21}, {2013, 05, 21}]

      assert ExXirr.xirr(d, v) == {:ok, 0.610359}
    end

    test "ok investment" do
      v = [1000.0, -600.0, -6000.0]
      d = [{1985, 1, 1}, {1990, 1, 1}, {1995, 1, 1}]

      assert ExXirr.xirr(d, v) == {:ok, 0.225683}
    end

    test "longterm investment" do
      v = [
        -105_187.06,
        -816_709.66,
        -479_069.684,
        -937_309.708,
        -88622.661,
        100_000.0,
        80000.0,
        403_627.95,
        508_117.9,
        789_706.87,
        88622.661,
        789_706.871,
        688_117.9,
        -403_627.95,
        -403_627.95,
        -789_706.871,
        88622.661,
        688_117.9,
        45129.14,
        26472.08,
        51793.2,
        126_605.59,
        278_532.29,
        99284.1,
        58238.57,
        113_945.03
      ]

      d = [
        {2011, 01, 07},
        {2011, 06, 07},
        {2011, 09, 07},
        {2012, 01, 18},
        {2012, 02, 03},
        {2012, 03, 03},
        {2012, 04, 19},
        {2012, 05, 23},
        {2012, 06, 23},
        {2012, 07, 23},
        {2012, 08, 11},
        {2012, 09, 11},
        {2012, 10, 11},
        {2012, 11, 11},
        {2012, 12, 12},
        {2013, 01, 12},
        {2013, 02, 12},
        {2013, 03, 12},
        {2013, 04, 11},
        {2013, 05, 11},
        {2013, 06, 11},
        {2013, 07, 11},
        {2013, 08, 28},
        {2013, 09, 28},
        {2013, 10, 28},
        {2013, 12, 28}
      ]

      assert ExXirr.xirr(d, v) == {:ok, 0.39132547}
    end

    test "converge on infinity" do
      v = [
        105_187.06,
        816_709.66,
        479_069.684,
        937_309.708,
        88622.661,
        100_000.0,
        80000.0,
        403_627.95,
        508_117.9,
        789_706.87,
        -88622.661,
        -789_706.871,
        -688_117.9,
        -403_627.95,
        403_627.95,
        789_706.871,
        88622.661,
        688_117.9,
        45129.14,
        26472.08,
        51793.2,
        126_605.59,
        278_532.29,
        99284.1,
        58238.57,
        113_945.03
      ]

      d = [
        {2011, 12, 07},
        {2011, 12, 07},
        {2011, 12, 07},
        {2012, 01, 18},
        {2012, 07, 03},
        {2012, 07, 03},
        {2012, 07, 19},
        {2012, 07, 23},
        {2012, 07, 23},
        {2012, 07, 23},
        {2012, 09, 11},
        {2012, 09, 11},
        {2012, 09, 11},
        {2012, 09, 11},
        {2012, 09, 12},
        {2012, 09, 12},
        {2012, 09, 12},
        {2012, 09, 12},
        {2013, 03, 11},
        {2013, 03, 11},
        {2013, 03, 11},
        {2013, 03, 11},
        {2013, 03, 28},
        {2013, 03, 28},
        {2013, 03, 28},
        {2013, 03, 28}
      ]

      assert ExXirr.xirr(d, v) == {:error, "Could not converge"}
    end

    test "wrong size" do
      d = [
        {2014, 04, 15},
        {2014, 10, 19}
      ]

      v = [
        -10000.0,
        305.6,
        500.0
      ]

      assert ExXirr.xirr(d, v) == {:error, "Date and Value collections must have the same size"}
    end

    test "wrong values" do
      d = [
        {2014, 04, 15},
        {2014, 10, 19}
      ]

      v = [
        305.6,
        500.0
      ]

      assert ExXirr.xirr(d, v) ==
               {:error, "Values should have at least one positive or negative value."}
    end

    test "not a bad investment" do
      d = [{2008, 2, 5}, {2008, 7, 5}, {2009, 1, 5}]
      v = [2750.0, -1000.0, -2000.0]

      assert ExXirr.xirr(d, v) == {:ok, 0.123631}
    end

    test "fail when the rate is too large" do
      d = [{2017, 1, 1}, {2017, 1, 5}]
      v = [10000, -11000]
      assert ExXirr.xirr(d, v) == {:error, "Unable to converge"}
    end

    test "check for arithmetic error for negative closing value" do
      d = [{1995, 10, 16}, {2003, 11, 14}, {2016, 11, 2}, {2022, 12, 26}]
      v = [1000, 0.0, -13511.34, 17034.345]

      assert ExXirr.xirr(d, v) ==
               {:error,
                "\"%ArithmeticError{message: \\\"bad argument in arithmetic expression\\\"}\""}
    end
  end
end
