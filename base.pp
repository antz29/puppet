/* Setup Sources */
class { 'apt':
	always_apt_update => true
}

/* Install Nginx */
class { 'nginx':
}

/* Install PHP */
class { 'phpfpm': 
}

/* Install Varnish */
class { 'varnish': 
}

/* Install MongoDB */
class { 'mongodb': 
}

/* Install Composer */
class { 'composer': 
}
