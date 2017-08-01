var i = 1;
$(function () {
    document.getElementById("b").onclick=function(){
        if(i>5){
            return false;
        }
        $("#add").before('<div class="form-group add'+i+'">'+
            '      <label class="col-md-4 control-label required">店铺名：</label>'+
            '      <div class="col-md-3">'+
            '      <input type="text" name="shopName" id="shopName'+i+'" class="form-control" placeholder="输入店铺名称"/>'+
            '      </div>'+
            '  </div>'+
            '  <div class="form-group add'+i+'">'+
            '      <label class="col-md-4 control-label required">小票号：</label>'+
            '      <div class="col-md-3">'+
            '      <input type="text" name="flowCode" id="flowCode'+i+'" class="form-control" placeholder="输入小票号"/>'+
            '      </div>'+
            '  </div>'+
            '  <div class="form-group add'+i+'">'+
            '      <label class="col-md-4 control-label required">金额：</label>'+
            '      <div class="col-md-3">'+
            '      <input type="text" name="amount" id="amount'+i+'" class="form-control" placeholder="输入金额"/>'+
            '      </div>'+
            '  </div>');
        i = i + 1;
        $.ajax({
            url: global.context + '/admin/shops/all',
            success: function (data) {
                $("#shopName"+(i-1)).autocomplete({
                    source: data.obj.map(function (o) {
                        return o.name;
                    })
                });
            }
        });
    }
    $("#minus").click(function(){
        if(i==1){
            return false;
        }
        $(".add"+(i-1)).each(function(){
            $(this).remove();
        });
        i--;
    });
    $('#mobile').focus();
    window.parent.scrollTo(0, 0);
    $.ajax({
        url: global.context + '/admin/shops/all',
        success: function (data) {
            $("#shopName").autocomplete({
                source: data.obj.map(function (o) {
                    return o.name;
                })
            });
        }
    });
    if ($.validator) {
        //fix: when several input elements shares the same name, but has different id-ies....
        $.validator.prototype.elements = function () {

            var validator = this,
                rulesCache = {};
            // select all valid inputs inside the form (no submit or reset buttons)
            // workaround $Query([]).add until http://dev.jquery.com/ticket/2114 is solved
            return $([]).add(this.currentForm.elements)
                .filter(":input")
                .not(":submit, :reset, :image, [disabled]")
                .not(this.settings.ignore)
                .filter(function () {
                    var elementIdentification = this.id || this.name;
                    // select only the first element for each name, and only those with rules specified
                    if (elementIdentification in rulesCache || !validator.objectLength($(this).rules()))
                        return false;
                    rulesCache[elementIdentification] = true;
                    return true;
                });
        };
    }
    $('#form').validate({
        onkeyup: false,
        rules: {
            mobile: {
                required: true,
                remote: {
                    url: global.context + '/admin/members/exist',
                    data: {
                        name: function () {
                            return $('#mobile').val();
                        }
                    }
                },
                minlength: 11,
                maxlength: 11
            },
            shopName: {
                required: true,
                remote:{
                    url:global.context + '/admin/shops/exists'
                }
            },
            flowCode: {
                required: true,
                remote: {
                    url: global.context + '/admin/trading/exist',
                    data: {
                        code: function () {
                            return $('#flowCode').val();
                        },
                        shopName: function () {
                            return $('#shopName').val();
                        }
                    }
                },
                maxlength:50
            },
            amount: {
                required: true,
                min : 0,
                number : true
            }
        },
        messages: {
            mobile: {
                remote: '用户不存在',
                required: '请输入手机',
                minlength: '请输入11位手机号',
                maxlength: '请输入11位手机号'
            },
            shopName: {
                remote: '店铺不存在',
                required: '请输入店铺名称'
            },
            flowCode: {
                required: '请输入流水号',
                remote: '该小票已积过分',
                maxlength:'小票流水号不能超过50位！'
            },
            amount: {
                required: '请输入金额',
                min : '必须是大于0的数字',
                number : '请输入数字'
            }
        },
        submitHandler:function(form){
        	
        }
    });
});

