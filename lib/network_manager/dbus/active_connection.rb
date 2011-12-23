class NetworkManager::DBus::ActiveConnection
  include DBusInterface::Object
  map_dbus :default_iface => 'org.freedesktop.NetworkManager.Connection.Active'
  
  def connection
    @connection ||= NetworkManager::DBus::SettingsConnection.new self['Connection']
  end

  def access_point
    if self['SpecificObject'].blank?
      nil
    else
      NetworkManager::DBus::AccessPoint.new(self['SpecificObject'])
    end
  end

end
