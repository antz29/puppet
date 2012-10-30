class newrelic {

	apt::source { "newrelic":
	  location      => "http://apt.newrelic.com/debian/",
	  release       => "newrelic",
	  repos         => "non-free",
	  key           => "548C16BF",
	  key_server    => 'download.newrelic.com',
	  include_src 	=> false 
	}  

	exec { 'updateapt-newrelic': 
	    command => '/usr/bin/apt-get update',
	    require => Apt::Source['newrelic']
	}

}