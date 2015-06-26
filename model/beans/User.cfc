component persistent="true" entityname="User" table="users" accessors="true" {

    property name="id";
    property name="login";
    property name="firstname";
    property name="lastname";
    property name="email";
    property name="phone";
    property name="address";
    property name="city";
    property name="province";
    property name="postalcode";
    property name="country";
    property name="link";
    property name="locale";
    property name="isactive";

    property name="roles"
             singularname="role"
             fieldtype="many-to-many"
             cfc="Role"
             linktable="users_roles"
             fkcolumn="id_user"
             inversejoincolumn="id_role"
             type="array";

    // non-persistent properties

    property name="moment" persistent="false";
    property name="lastactionmoment" persistent="false";
    property name="sessiontoken" persistent="false";
    property name="token" persistent="false";

    public any function init(){
        VARIABLES.setID(0);
        VARIABLES.setLogin('');
        VARIABLES.setFirstName('');
        VARIABLES.setLastName('');
        VARIABLES.setEmail('');
        VARIABLES.setPhone('');
        VARIABLES.setAddress('');
        VARIABLES.setCity('');
        VARIABLES.setProvince('');
        VARIABLES.setPostalCode('');
        VARIABLES.setCountry('');
        VARIABLES.setLink('');
        VARIABLES.setLocale('');
        VARIABLES.setIsActive(1);

        VARIABLES.setRoles = ArrayNew(1);

        VARIABLES.setMoment(Now());
        VARIABLES.setLastActionMoment(Now());
        VARIABLES.setSessionToken('');

        return THIS;
    }

    public string function getRolesList() {
        var result = "";

        loop array="#VARIABLES.getRoles()#" index="r" {
            LOCAL.result = ListAppend(LOCAL.result, r.getSingularName());
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
