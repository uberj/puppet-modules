
class glaspot::running (){
    exec { 'start-glaspot':
		unless => "/etc/init.d/glaspot status",
        command => "/etc/init.d/glaspot start",
    }
}
