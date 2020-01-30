# frozen_string_literal: true

describe 'Windows NetworkingNetmask' do
  context '#call_the_resolver' do
    let(:value) { '255.255.240.0' }
    subject(:fact) { Facter::Windows::NetworkingNetmask.new }

    before do
      allow(Facter::Resolvers::Networking).to receive(:resolve).with(:netmask).and_return(value)
    end

    it 'calls Facter::Resolvers::Networking' do
      expect(Facter::Resolvers::Networking).to receive(:resolve).with(:netmask)
      fact.call_the_resolver
    end

    it 'returns netmask for ipv4 ip address fact' do
      expect(fact.call_the_resolver).to be_an_instance_of(Array).and \
        contain_exactly(an_object_having_attributes(name: 'networking.netmask', value: value),
                        an_object_having_attributes(name: 'netmask', value: value, type: :legacy))
    end
  end
end