$(function () {

    $.datepicker.setDefaults($.datepicker.regional["zh-CN"]);

    $('.datepicker').datepicker({
        dateFormat: 'yy-mm-dd',
        changeMonth: true,
        changeYear: true
    });

    $('div.col-md-5 input').change(
        function(event) {
            var source = $(event.target);
            var id = source.attr('id');
            $.ajaxFileUpload({
                url : global.context + '/admin/upload',
                secureuri : false,
                fileElementId : source.attr('id'),
                dataType : 'json',
                success : function(data, status) {
                    if (status == 'success') {
                        $('div.col-md-5 img').attr('src',
                            global.url + data.responseText);
                        $('#imgHref').val(global.url + data.responseText);
                    }
                },
                error : function(data, status, e) {
                    alert(e);
                }
            });
            return false;
        });

    $('#form').validate({
        onkeyup: false,
        rules: {
            name: {
                required: true,
                maxlength: 10,
                remote: {
                    url: global.context + '/admin/restaurant/coupon/name/duplicate',
                    data: {
                        name: function () {
                            return $('#name').val()
                        },
                        id: $('#form').attr('data-id')
                    }
                }
            },
            phone: {
                maxlength: 11,
                minlength: 11,
                remote: {
                    url: global.context + '/admin/restaurant/coupon/phone/duplicate',
                    data: {
                        phone: function () {
                            return $('#phone').val()
                        },
                        id: $('#form').attr('data-id')
                    }
                }
            }
        },
        messages: {
            name: {
                required: '名称不能为空',
                maxlength: '名称最长不能超过10',
                remote: '名称重复'
            },
            phone: {
                maxlength: '请输入11位手机号',
                minlength: '请输入11位手机号',
                remote: '手机号重复'
            }
        }
    });
})
