require 'spec_helper'

describe Fuey::Inspections::RFCPing do
  it_behaves_like "an inspection"

  Given (:config) {
    {
      'ashost' => '1.0.0.1',
      'sysnr' => "00",
      'client' => "400",
      'user' => 'chud',
      'passwd' => 'gobrowns',
      'lang' => 'EN'
    }
  }
  Given (:rfc_ping) { Fuey::Inspections::RFCPing.new config }


  context "when the ping fails" do
    Given (:conn) { double Fuey::Inspections::Support::SAP }
    Given { Fuey::Inspections::Support::SAP.should_receive(:new).with(config).and_return(conn) }
    Given { conn.stub(:ping).and_return(false) }
    When  (:result) { rfc_ping.execute }
    Then  { expect( result ).to be_false }
  end

  context "when the ping succeeds" do
    Given (:conn) { double Fuey::Inspections::Support::SAP }
    Given { Fuey::Inspections::Support::SAP.should_receive(:new).with(config).and_return(conn) }
    Given { conn.stub(:ping).and_return(true) }
    When  (:result) { rfc_ping.execute }
    Then  { expect( result ).to be_true }
  end
end
