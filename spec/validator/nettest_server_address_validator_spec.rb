#!/usr/bin/env rspec

require 'spec_helper'
require File.join(File.dirname(__FILE__), '../../', 'validator', 'nettest_server_address.rb')

module MCollective
  module Validator
    class Nettest_server_addressValidator
      describe '#validate' do

        before do
          Validator.expects(:typecheck)
          Validator.expects(:validate)
        end

        it 'should validate a server:port argument' do
          Nettest_server_addressValidator.validate('host.example.com:8080')
        end

        it 'should fail if no port was supplied' do
          lambda {
            Nettest_server_addressValidator.validate('host.example.com')
          }.should raise_error ValidatorError
        end

        it 'should fail if no hostname was supplied' do
          lambda {
            Nettest_server_addressValidator.validate(':8080')
          }.should raise_error ValidatorError
        end

        it 'should fail if hostname is invalid' do
          lambda {
            Nettest_server_addressValidator.validate('localhost#:8080')
          }.should raise_error ValidatorError
        end

        it 'should fail if port number is invalid' do
          lambda {
            Nettest_server_addressValidator.validate('host.example.com:rspec')
          }.should raise_error ValidatorError
        end
      end
    end
  end
end
