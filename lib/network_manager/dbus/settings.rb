class NetworkManager::DBus::Settings
  include DBusInterface::Object
  map_dbus :default_iface => 'org.freedesktop.NetworkManagerSettings',
             :object_path => '/org/freedesktop/NetworkManagerSettings'
  no_properties!
  
  # TODO methods
  # GetConnectionByUuid
  
  # TODO signals
  # PropertiesChanged
  
  property 'Hostname'
  property 'CanModify', :boolean
  
  def self.connections
    instance.connections
  end
  
  # @return [Array<NetworkManager::DBus::SettingsConnection>] connections
  def connections
    call('ListConnections').map do |list|
      list.map do |object_path|
        ::NetworkManager::DBus::SettingsConnection.new(object_path)
      end
    end.flatten
  end
  
  # @param [Hash] connection hash
  def add_connection(connection_hash)
    call('AddConnection', connection_hash)
  rescue DBus::Error => e
    puts e.inspect
  end
  
  # @param [String] new_hostname
  def hostname=(new_name)
    call('SaveHostname', new_name)
  end
end
