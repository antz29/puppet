class varnish {

	apt::source { "varnish" :
	  location      => "http://repo.varnish-cache.org/ubuntu",
	  release       => "precise",
	  repos         => "varnish-3.0",
	  key           => "F7124B7D",
	  key_source    => 'http://repo.varnish-cache.org/ubuntu/GPG-key.txt',
	  include_src 	=> false 
	}  

	package { 'varnish':
  		ensure => installed,
  		require => Apt::Source['varnish']
	}

	file { "/etc/varnish/default.vcl": 
	  ensure      	=> present,
	  source      => "puppet:///modules/varnish/default.vcl",
	  group       	=> 'root',
	  mode        	=> '0644'
	}

	service { 'varnish':
	    ensure 		=> running,
	    require 	=> [ Package['varnish'] ],
	    subscribe  	=> File['/etc/varnish/default.vcl']
	}

}