include apt

/* Setup Sources */

/* Install Nginx */
class { 'nginx':
}

/* Install PHP */
class { 'phpfpm': 
}

/* Install MongoDB */
class { 'mongodb': 
}

/* Install Composer */
class { 'composer': 
}
