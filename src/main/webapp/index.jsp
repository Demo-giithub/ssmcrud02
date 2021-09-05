<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>
<!-- 更新员工的模态框 -->
<div class="modal fade" id="updateEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">编辑员工</h4>
            </div>
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-2 control-label">empName</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="empName_update_static"></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">email</label>
                    <div class="col-sm-10">
                        <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email">
                        <span class="help-block"></span>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">gender</label>
                    <div class="col-sm-10">
                        <label class="radio-inline">
                            <input type="radio" id="gender1_update_input" name="gender" value="M" checked="checked"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" id="gender2_update_input" name="gender" value="N"> 女
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">deptName</label>
                    <div class="col-sm-5">
                        <select class="form-control" name="dId" id="update_dept_select">
                            <%--这里面的标签在下面的 department() 函数中--%>
                        </select>
                    </div>
                </div>


            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="btn_update_emp">更新</button>
            </div>
        </div>
    </div>
</div>



<!-- 新增员工的弹窗 -->
<div class="modal fade" id="addEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="empAddModal">新增员工</h4>
            </div>
            <form class="form-horizontal">
                <div class="form-group">
                    <label class="col-sm-2 control-label">empName</label>
                    <div class="col-sm-10">
                        <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">email</label>
                    <div class="col-sm-10">
                        <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email">
                        <span class="help-block"></span>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">gender</label>
                    <div class="col-sm-10">
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="inlineRadio1" value="M" checked="checked"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="inlineRadio2" value="N"> 女
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">deptName</label>
                    <div class="col-sm-5">
                        <select class="form-control" name="dId" id="dept_select">
                            <%--这里面的标签在下面的 department() 函数中--%>
                        </select>
                    </div>
                </div>


            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="btn_save_emp">保存</button>
            </div>
        </div>
    </div>
</div>



<%--搭建页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--两个按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary glyphicon glyphicon-plus" id="emp_add_modal_but">增加</button>
            <button class="btn btn-danger glyphicon glyphicon-trash" id="emp_delete_modal_but">批量删除</button>
        </div>
    </div>
    <%--显示页面数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>EmpName</th>
                    <th>Gender</th>
                    <th>Email</th>
                    <th>DeptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="empBody">

                </tbody>


            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="pt">

        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="paging">

        </div>
    </div>


</div>



<script type="text/javascript">
    $(function () {
        page_in(1)
    });

    //当前页码
    var the_current_page;

    //这个函数用来请求分页信息，分页信息保存在result中
    function page_in(pn){
        //去掉全选按钮的选中
        $("#check_all").prop("checked","")
        $.ajax({
            url:"${APP_PATH}/emps",
            type:"GET",
            data:"pn=" + pn,
            success:function (result) {
                console.log(result);
                //处理分页信息
                build_emps_table(result);
                //处理分页条文字部分
                build_page_info(result);
                //处理分页条信息
                build_page_nav(result);
                the_current_page = result.extend.pageInfo.pageNum;
            }
        });
    }
    //将获取来的分页信息进行解析，放入HTML中 <tbody />标签中表单信息
    function build_emps_table(result){
        $("#empBody").empty()
        var emps = result.extend.pageInfo.list;
        $.each(emps,function (index, item) {
            var checkBoxId = $("<td />").append("<input type='checkbox' class='check_item'/>" )
            var empId = $("<td />").append(item.empId);
            var empName = $("<td />").append(item.empName);
            var gender = $("<td></td>").append(item.gender=='M'?'男':'女');
            var email = $("<td></td>").append(item.email);
            var deptName = $("<td></td>").append(item.department.deptName);
            var editBut = $("<button></button>")
                .addClass("btn btn-primary btn-sm")
                .append("<span></span>")
                .addClass("glyphicon glyphicon-pencil edit_btn")
                .attr("edit_id",item.empId)
                .append("编辑");
            var deleteBut = $("<button></button>")
                .addClass("btn btn-danger btn-sm")
                .append("<span></span>")
                .addClass("glyphicon glyphicon-trash delete_btn")
                .attr("delete_id",item.empId)
                .append("删除");
            var but = $("<td></td>").append(editBut).append(" ").append(deleteBut);

            $("<tr></tr>")
                .append(checkBoxId)
                .append(empId)
                .append(empName)
                .append(gender)
                .append(email)
                .append(deptName)
                .append(but)
                .appendTo("#empBody");
        })
    }

    //处理分页信息
    function build_page_info(result) {
        $("#pt").empty()
        $("#pt").addClass("col-md-6").append("当前"+ result.extend.pageInfo.pageNum +"页")
            .append(",总共"+result.extend.pageInfo.pages+"页")
            .append(",总记录数" + result.extend.pageInfo.total)
        //给当前页面赋值
        currentPage = result.extend.pageInfo.pageNum;
    }

    //处理分页条信息
    function build_page_nav(result) {
        $("#paging").empty()
        //下面变量为首页按钮和上一页按钮
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#").attr("aria-label","Previous"));
        //判断是否还有前一页 若为false表示没有前一页
        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled")
            prePageLi.addClass("disabled")
        }else{
            //给首页按钮绑上单击事件
            firstPageLi.click(function () {
                page_in(1)
            })
            //给上一页按钮绑上单击事件
            prePageLi.click(function () {
                page_in(result.extend.pageInfo.pageNum-1)
            })
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#").attr("aria-label","Previous"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

        //判断是否还有后一页 若为false表示没有后一页
        if(result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled")
            lastPageLi.addClass("disabled")
        }else{
            //给末页按钮绑上单击事件
            lastPageLi.click(function () {
                page_in(result.extend.pageInfo.pages)
            })
            //给下一页按钮绑上单击事件
            nextPageLi.click(function () {
                page_in(result.extend.pageInfo.pageNum+1)
            })
        }
        var ul = $("<ul></ul>")
            .addClass("pagination")
            .append(firstPageLi)
            .append(prePageLi);
        //通过ajax语法遍历页码数组（navigatepageNums 为PageInfo携带的页码数组）
        $.each(result.extend.pageInfo.navigatepageNums,function (index, item) {
            var page = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
            ul.append(page)
            if(result.extend.pageInfo.pageNum == item){
                page.addClass("active")
            }
            //给每个当行条编号绑上单击事件
            page.click(function () {
                page_in(item)
            })
        });
        ul.append(nextPageLi).append(lastPageLi);
        var nav = $("<nav></nav>").attr("aria-label","Page navigation").append(ul);
        $("#paging").append(nav).append(ul);
    }
    /*给新增添加点击事件
    * 然后对部门进行请求
    * 在就是最烦人的校验
    * */
    //在点击新增按钮时，绑定单击事件
    $("#emp_add_modal_but").click(function () {
        //在每次点击增加前应将前一次输入的内容清除掉
        /*myform 是form的id属性值
        1.调用reset（）方法
         function fomrReset()
         {
                这是原生js方法
                document.getElementById("myform").reset();
                [0] 是获取document对象
                $("#addEmpModal form")[0].reset();
         }*/
        $("#addEmpModal form")[0].reset();
        $("#addEmpModal form").find(".help-block").text('');
        $("#addEmpModal form").find("*").removeClass("has-success has-error")



        //department函数会获取到部门信息
        department("#dept_select")
        //启动模态框
        $('#addEmpModal').modal({
            backdrop:"static"
        })
    });
    //发送ajax请求，获取到部门信息
    function department(ele) {
        //为什么要这行代码？$(ele).empty();
        //因为在每次获取部门前，需要将上一次获取到的信息清空，才不会出现内容叠加。
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/dept",
            type:"GET",
            success:function (result) {
                $.each(result.extend.department,function () {
                    //为什么要给每个选项设置value属性？
                    //因为点击保存的时候需要将这些信息提交给后台的，设置deptId后台就可以直接根据提供的deptId进行保存到数据库
                    // <option value="3">信息部</option>
                    $(ele).append($("<option></option>").append(this.deptName).attr("value",this.deptId))
                })

            }
        })
    }
    //增加模态框中的保存按钮添加点击事件
    $("#btn_save_emp").click(function () {
        //在保存信息之前呀，咱们得进行前端校验
        if(!frontEndVerification()){
            return false;
        }
        //后端验证
        if($("#empName_add_input").attr("page_info") == "error"){
            return false;
        }
        if($("#email_add_input").attr("page_info") == "error"){
            return false;
        }
        //将表单中的信息序列化，并通过json传递到后端
        var data = $("#addEmpModal form").serialize();
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:data,
            success:function (result) {
                //1、保存员工成功后需要关闭模态框（就是那个新增弹窗）
                //2、保存成功后显示走后一页（也就是显示保存的员工信息）
                $('#addEmpModal').modal('hide')
                page_in(9999999);
            }
        });
    });

    //前端校验函数
    function frontEndVerification() {
        //验证用户名和邮箱
        //1.获取用户名
        var empName = $("#empName_add_input").val();
        var regular_expression_name = /^[a-z0-9_-]{6,16}$/
        var empEmail = $("#email_add_input").val();
        var regular_expression_email = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/
        //name校验
        if(regular_expression_name.test(empName)){
            //满足正则表达式
            show_status("#empName_add_input","success","用户名可用(前端校验)")
        }else{
            //不满足正则表达式
            show_status("#empName_add_input","error","用户名3-16位的英文字母或数字(前端校验)")
            return false;
        }
        return true;
    }

    /**
     * @param ele dom对象
     * @param status 状态 success/error
     * @param msg 反馈到前端的信息
     */
    function show_status(ele,status,msg) {
        //清空设置的样式和内容
        $(ele).parent().removeClass("has-success has-error");
        //根据传递进来的状态进行判断
        if (status == "success"){
            $(ele).parent().addClass("has-success")
            $(ele).next().text(msg)
        } else {
            $(ele).parent().addClass("has-error")
            $(ele).next().text(msg)
        }
    }
    //对表单中的empName进行后端校验
    $("#empName_add_input").change(function () {
        var empName = $("#empName_add_input").val();
        $.ajax({
            url:"${APP_PATH}/checkEmpName",
            type:"POST",
            data:"empName="+ empName,
            success:function (result) {
                console.log(result)
                if(result.code == 200){
                    show_status("#empName_add_input","success","用户名可用(后端验证)")
                    $("#empName_add_input").attr("page_info","success")
                }else{
                    show_status("#empName_add_input","error",result.extend.info)
                    $("#empName_add_input").attr("page_info","error")
                }
            }
        })
    });
    //对表单中的empEmail进行后端校验
    $("#email_add_input").change(function () {
        $.ajax({
            url:"${APP_PATH}/checkEmpEmail",
            type:"POST",
            data:"empEmail="+ $("#email_add_input").val(),
            success:function (result) {
                if(result.code == 200){
                    show_status("#email_add_input","success","此邮箱可用(后端验证)")
                    $("#email_add_input").attr("page_info","success")
                }else{
                    show_status("#email_add_input","error",result.extend.info)
                    $("#email_add_input").attr("page_info","error")
                }
            }
        })
    });
    //员工ID
    var empId;
    //对编辑按钮添加点击事件，由于编辑按钮是之后通过ajax请求获取的，没有经过JavaScript的主函数解析，所有不能直接使用点击事件
    $(document).on("click",".edit_btn",function () {
        //在点击编辑按钮时，获取当前员工的empId
        empId = $(this).attr("edit_id");
        //获取员工信息
        getEmpById($(this).attr("edit_id"));
        //department函数会获取到部门信息
        department("#update_dept_select")
        //启动模态框
        $('#updateEmpModal').modal({
            backdrop:"static"
        })
    })
    function getEmpById(empId) {
        $.ajax({
            url:"${APP_PATH}/emp/" +empId,
            type:"GET",
            success:function (result) {
                console.log(result)
                var info = result.extend.employee;
                $("#empName_update_static").text(info.empName);
                $("#email_update_input").val(info.email);
                $("#updateEmpModal input[name=gender]").val([info.gender])
                $("#update_dept_select select").val(info.dId)
            }
        })
    }

    //更新按钮绑定事件
    $(document).on("click","#btn_update_emp",function () {
        $.ajax({
            url:"${APP_PATH}/emp/" + empId,
            type:"POST",
            data:$("#updateEmpModal form").serialize() +"&_method=PUT",
            success:function () {
                //关闭模态框
                $("#updateEmpModal").modal("hide")
                //来到当前页码
                page_in(the_current_page);
            }
        })
    })
    //删除点击按钮
    $(document).on("click",".delete_btn",function () {
        if(confirm("确定要删除["+ $(this).parents("tr").find("td:eq(2)").text() +"]吗？")){
            $.ajax({
                url:"${APP_PATH}/emp",
                type:"POST",
                data:"delete_id=" + $(this).attr("delete_id") + "&_method=DELETE",
                success:function () {
                    page_in(the_current_page);
                }
            })
        }
    })
    //全选/全不选功能实现
    $("#check_all").click(function () {
        $(".check_item").prop("checked",$(this).prop("checked"))
    })
    $(document).on("click",".check_item",function () {
        var flag = $(".check_item:checked").length == $(".check_item").length;
        if(flag){
            $("#check_all").prop("checked","checked")
        }else{
            $("#check_all").prop("checked","")
        }
    })
    var empNames = "";
    var del_id = "";
    $("#emp_delete_modal_but").click(function () {
        if($(".check_item:checked").length == 0){
            alert("抱歉！未选择要删除的员工")
            return ;
        }

        $.each($(".check_item:checked"),function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() +",";
            del_id += $(this).parents("tr").find("td:eq(1)").text() +"-";
        })

        empNames = empNames.substring(0,empNames.length-1);
        del_id = del_id.substring(0,del_id.length-1);

        if(confirm("确定要删除["+ empNames +"]吗？")){
            $.ajax({
                url:"${APP_PATH}/emp/"+del_id,
                type:"POST",
                data:"&_method=DELETE",
                success:function () {
                    page_in(the_current_page);
                }
            })
        }
    });
</script>
</body>
</html>
