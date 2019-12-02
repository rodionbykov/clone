
<cfset cols = {id: 'ID', login: 'Login'} />

<cf_datatable
    width="100%"
    class="table"
    data="#rc.users#"
    cols="#cols#"
/>
