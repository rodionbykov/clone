component persistent="true" entityname="User" table="users" accessors="true" {

    property name="id";
    property name="login";

    property name="sessions"
             singularName="session"
             fieldtype="one-to-many"
             cfc="Session"
             fkcolumn="id_user"
             type="array"
             where="isactive = 1";

    property name="settings"
             singularName="setting"
             fieldtype="one-to-many"
             cfc="Setting"
             fkcolumn="id_user"
             type="array";

    property name="roles"
             singularname="role"
             fieldtype="many-to-many"
             cfc="Role"
             linktable="users_roles"
             fkcolumn="id_user"
             inversejoincolumn="id_role"
             type="array";

    public any function init(){
        VARIABLES.setID(0);
        VARIABLES.setLogin('');

        VARIABLES.setSessions(ArrayNew(1));
        VARIABLES.setRoles(ArrayNew(1));
        VARIABLES.setSettings(ArrayNew(1));

        return THIS;
    }

    public string function getRolesList() {
        var result = "";

        loop array="#VARIABLES.getRoles()#" index="r" {
            LOCAL.result = ListAppend(LOCAL.result, r.getSingularName());
        }

        return LOCAL.result;
    }

    public string function getTokensList() {
        var result = "";

        loop array="#VARIABLES.getRoles()#" index="r" {
            LOCAL.result = ListAppend(LOCAL.result, r.getTokens());
        }

        return ListRemoveDuplicates(LOCAL.result);
    }

    public boolean function inRole(string arg_rolename){
        var result = false;

        loop array="#VARIABLES.getRoles()#" index="r" {
            if(r.getSingularName() EQ arg_rolename OR r.getPluralName() EQ arg_rolename){
               LOCAL.result = true;
            }
        }

        return LOCAL.result;
    }

    public boolean function isGranted(string rolename){
        var result = false;
        var roleslist = VARIABLES.getRolesList();

        LOCAL.result = ListFindNoCase(LOCAL.roleslist, ARGUMENTS.rolename);

        return LOCAL.result GT 0 ? true : false;
    }
}
