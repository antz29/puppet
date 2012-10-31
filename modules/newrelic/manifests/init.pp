class newrelic {

	apt::source { "newrelic":
		location      => "http://apt.newrelic.com/debian/",
		release       => "newrelic",
		repos         => "non-free",
		key           => "548C16BF",
		key_server    => 'subkeys.pgp.net',
		include_src 	=> false 
	}  

	exec { 'updateapt-newrelic': 
		command => '/usr/bin/apt-get update',
		require => Apt::Source['newrelic']
	}

	package { 'newrelic-php5':	
		ensure => installed,
		require => Exec['updateapt-newrelic']
	}

	package { 'newrelic-sysmond':
		ensure => installed,
		require => Exec['updateapt-newrelic']
	}

	file { "/etc/newrelic/newrelic.cfg": 
	  ensure      	=> present,
	  source      => "puppet:///modules/newrelic/newrelic.cfg",
	  group       	=> 'root',
	  mode        	=> '0644'
	}

	file { "/etc/newrelic/nrsysmond.cfg": 
	  ensure      	=> present,
	  source      => "puppet:///modules/newrelic/nrsysmond.cfg",
	  group       	=> 'root',
	  mode        	=> '0644'
	}

	service { 'newrelic-sysmond':
	    ensure => running,
	    subscribe  => File['/etc/newrelic/nrsysmond.cfg'],
	    require => Package['newrelic-sysmond'],
	}

	service { 'newrelic-daemon':
	    ensure => running,
	    subscribe  => File['/etc/newrelic/newrelic.cfg'],
	    require => Package['newrelic-php5'],
	}

}