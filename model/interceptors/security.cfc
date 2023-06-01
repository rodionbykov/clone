component {

    function before(targetBean, methodName, args) {
        writedump(targetBean);
        writedump(methodName);
        writedump(args);
        abort;
        arguments.args.input = "before" & arguments.args.input;
        writeOutput("dfsdf0");
    }

}
