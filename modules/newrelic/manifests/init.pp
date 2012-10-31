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
	  ensure      => present,
	  source      => "/etc/newrelic/newrelic.cfg.template",
	  group       => 'root',
	  mode        => '0644',
	  require => Package['newrelic-php5']
	}

	service { 'newrelic-sysmond':
	    ensure => running,
	    subscribe  => File['/etc/php5/fpm/pool.d/www.conf'],
	    require => Package['php5-fpm'],
	}

	service { 'newrelic-sysmond':
	    ensure => running,
	    subscribe  => File['/etc/php5/fpm/pool.d/www.conf'],
	    require => Package['php5-fpm'],
	}

}