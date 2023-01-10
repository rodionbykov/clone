component {

    function checkConfigFolder() {
        if(not DirectoryExists(APPLICATION.configDirectory)) {
            DirectoryCreate(APPLICATION.configDirectory);
        }
    }

}
