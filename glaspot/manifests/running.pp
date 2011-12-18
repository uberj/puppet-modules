
class glaspot::running (){
    exec { 'start-glaspot':
        command => "/etc/init.d/glaspot start",
    }
}
