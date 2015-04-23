/*!
 * YHUI yhValidate  @VERSION
 *
 * Depends:
 *     jquery.core
 *     jquery.widget
 *     jquery.position
 *     yhCore
 */
(function( $, undefined ){
    $.widget( "yhui.yhValidate", {
        version: "@VERSION",

        options: {
            debug: false,
            ignore: "[type=hidden]",
            messages: null,
            methods: null,
            position: {
                at: "right center",
                my: "left center"
            },
            rules: null,
            starTip: "",
            validateOnSubmit: true
        },

        methods: {
            required: function( value, field ) {
                var ret;
                if ( !this._checkable(field) ) {
                    ret = $.trim(value).length > 0;
                } else {
                    ret = !!$( field ).find( "input" ).filter( ":checked" ).length;
                }
                return ret;
            },

            minLength: function( value, field, param ) {
                return value.length >= param;
            },

            maxLength: function( value, field, param ) {
                return value.length <= param;
            },

            equalTo: function( value, field, param ) {
                var $target = $("#" + param);
                if ( !$target.length ) {
                    return $.yhui.log( "没有匹配的元素" );
                }
                return value === $target.val();
            },

            remote: function( value, field, param ) {
                var that = this,
                    data = {},
                    flag = this._getFlag( field );
                if ( $.data( field, "remoteValid" ) === value ) {
                    if ( flag in this.remoteErrorMap ) {
                        delete this.remoteErrorMap[ flag ];
                    }
                    return true;
                }
                
                if ( !this.remoteErrorMap ) {
                    this.remoteErrorMap = {};
                    this.remotedAll = true;
                }

                data[ flag ] = value;
                param = typeof param === "string" && { url: param } || param;

                if ( this.xhr && this.xhr[flag] && this.xhr[flag].readyState != 4 ) {
                    this.xhr[ flag ].abort();
                }
                this._startRequest( field );
                this.xhr[ flag ] =
                    $.ajax( $.extend( true, {
                        dataType: "json",
                        data: data,
                        async: false,
                        success: function( response ) {
                            var valid = response === true || response === "true";
                            if ( valid ) {
                                that._cancelError( field );
                                if ( flag in that.remoteErrorMap ) {
                                    delete that.remoteErrorMap[ flag ];
                                }
                                $.data( field, "remoteValid", value );
                            } else {
                                var message = that._messages( field, $.data(field, "currentRule"), true );
                                if ( !(flag in that.remoteErrorMap) ) {
                                    that.remotedAll && (that.remotedAll=false);
                                    that.remoteErrorMap[ flag ] = {
                                        element: field,
                                        message: message
                                    };
                                }
                                that._showError( field, message );
                                if ( !that.tip || (that.tip && that.tip.is(":hidden")) ) {
                                    that._tip( field, message );
                                }
                                $.removeData( field, "remoteValid" );
                            }
                            that._stopRequest( field, valid, flag );
                        },
                        error: function( s1, s2 ) {
                            that.options.debug && $.yhui.log( s2 );
                        }
                    }, param) );
                var rd = this.xhr[ flag ].responseText;
                var valid = rd === true || rd === "true";
                if(valid){
                	return valid;
                }else{
                	return false;
                }
            },
            
            minChecked: function( value, field, param ) {
                return $( field ).find( "input" ).filter( ":checked" ).length >= param;
            },
            
            maxChecked: function( value, field, param ) {
                return $( field ).find( "input" ).filter( ":checked" ).length <= param;
            },

            email: function ( value ) {
                return /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/.test( value );
            },
            phone: function ( value ) {
                return /^(0\d{2,3})?-?\d{7,8}$/.test( value );
            },
            mobile: function ( value ) {
                return /^0?1[3|5|8][0-9]-?\d{8}$/.test( value );
            },
            url: function ( value ) {
                return /^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test( value );
          },
            number: function( value ) {
				  return /^\d+$/.test( value );
			  }
        },

        messages: {
            required: "此字段必须填写",
            remote: "经验证，表单值不合法",
            email: "输入的邮箱地址无效",
            equalTo: "请与上一个值保持一致",
            maxLength: "最多{0}个字符",
            maxChecked: "至多选择{0}项",
            minLength: "最少{0}个字符",
            minChecked: "至少选择{0}项",
            mobile: "输入的手机号码无效",
            phone: "输入的电话号码无效",
            file: "选择上传的文件",
            url: "输入的地址无效",
            number:"请填写正确的数字"
        },

        _create: function() {
            if ( this.element[0].nodeName.toLowerCase() !== "form" ) {
                return $.yhui.log( "yhValidate 只作用于表单元素" );
            }
            if ( this.options.methods ) {
                $.extend( true, this.methods, this.options.methods );
            }
            var rules,
                that = this;
            if ( !$.isEmptyObject(rules=this.options.rules) ) {
                $.each( rules, function( fieldFlag, rule ) {
                    rules[ fieldFlag ] = that._normalizeRule( rule );
                });
            }
            this.elements = this._getElements();
            this.element.attr( "novalidate", "novalidate" )[0].reset();
            this._events();
            var starTip;
            if ( starTip = this.options.starTip ) {
                this.element.tooltip({
                    items: ".yhui-form-required",
                    content: starTip
                });
            }
        },

        _addStar: function( elem ) {
            var ico = "<span class = 'yhui-form-icon yhui-form-required'></span>";
            if ( $( elem ).closest(":yhui-yhformfield").length ) {
                $( elem ).eq( 0 ).closest( "td" ).prev().prepend( ico );
            }
        },

        _events: function() {
            var that = this,
                textSelector = ":data(rules):not(:data(yhDatePicker))" +
                    ":data(rules):not(:data(yhDropDown))";

            $.yhui.windowResize( function() {
                if ( that.tip && that.tip.is(":visible") ) {
                    that.tip.position( $.extend(that.options.position, {
                        of: $.data( that.tip[0], "target" )
                    }));
                }
            }, this.eventNamespace, this.window );

            this.element
                .on( this._namespace("submit"), function(e) {
                    if ( that.options.debug ) {
                        e.preventDefault();
                    }
                    if ( !that._form() && !that.formSubmit ) {
                        e.preventDefault();
                    }
                })
                .on( this._namespace("mouseenter focus"), ".yhui-validate", function() {
                    var message, field = this;
                    if ( this.className.indexOf("yhui-dropdown") > -1 ) {
                        field = $( this ).find("input[type=text]");
                    }
                    var $field = $(field);
                    // confused here, the result is different
                    //$.yhui.log( $.data(field,"message") );
                    //$.yhui.log( $field.data("message") );
                    if ( (message = $field.data("message")) && !$field.attr("data-hastip") ) {
                        that._tip( field, message );
                    }
                })
                .on( this._namespace("change"), ":data(rules)>[type=radio],:data(rules)>[type=checkbox]", function(e) {
                    that._checkField( this.parentNode );
                })
                .on( this._namespace("keyup"), textSelector, function() {
                    that._checkField( this );
                })
                .on( this._namespace("yhdatepickerhide"), ":data(yhDatePicker)", function() {
                    that._checkField( this );
                })
                .on( this._namespace("yhdropdownhide"), ":data(yhDropDown)", function() {
                    that._checkField( this );
                });
        },

        _namespace: function( event ) {
            return $.yhui.parseEventType( event, this.eventNamespace );
        },

        _getElements: function() {
            var that = this,
                rulesCache = {};
            return this.element.find( "input, select, textarea, span.yhui-form-checkable" )
                .not("[type=submit], [type=reset], [type=image], [disabled],[dropdown]")
                .not( this.options.ignore )
                .filter(function() {
                    var flag = that._getFlag( this );
                    if ( flag in rulesCache || $.isEmptyObject(that._rules(this))) {
                        return false;
                    }
                    //此处是解决配了校验规则，但无需必须填写项时，原来仍会加星标识，其实不要加星标识的
                    if(!($.isEmptyObject(that._rules(this))) && !("required" in that._rules(this))) return true;
                    that._addStar( this );
                    return true;
                });
        },

        _rules: function( element ) {
            var rules;
            if ( rules = $.data( element, "rules" ) ) {
                return rules;
            }
            rules = $.extend( true, {}, this._staticRules( element ), this._attributeRules( element ) );
            rules = this._normalizeRules( rules );
            if ( rules.required ) {
                var param = rules.required;
                delete rules.required;
                rules = $.extend( { required: param }, rules );
            }
            $.isEmptyObject( rules ) || $.data( element, "rules", rules );
            return rules;
        },

        _form: function() {
            this.checkForm();
            //this._parseErrorField();//已经把该方法放入checkForm方法里面了
            return this._valid();
        },

        _valid: function() {
            return $.isEmptyObject( this.errorMap ) && $.isEmptyObject(this.pending) && $.isEmptyObject(this.remoteErrorMap);
        },

        _attributeRules: function( element ) {
            var method, value,
                rules = {},
                $element = $(element);
            for ( method in this.methods) {
                if ( /^(required|phone|mobile|email|url|number)$/.test(method) ) {
                    value = $element.attr( method );
                    if ( value === "" ) {
                        value = true;
                    }
                    value = value === "false" ? "false" : (!!value);
                } else {
                    value = $element.attr( method );
                }

                if ( value ) {
                    rules[method] = value;
                }
            }
            if ( rules.maxLength && /-1|2147483647|524288/.test(rules.maxLength) ) {
                delete rules.maxLength;
            }
            return rules;
        },

        _staticRules: function( elem ) {
            var rules  = {},
                flag = this._getFlag( elem ),
                r = this.options.rules;
            if ( !$.isEmptyObject(r) && r[ flag ] ) {
                rules = r[ flag ];
            }
            return rules;
        },

        _normalizeRule: function( rule ) {
            if ( typeof rule === "string" ) {
                var transformed = {};
                $.each(rule.split(/\s/), function() {
                    transformed[this] = true;
                });
                rule = transformed;
            }
            return rule;
        },

        _normalizeRules: function( rules ) {
            $.each( rules, function( prop, val ) {
                if ( val === "false" || val === false ) {
                    delete rules[prop];
                    return;
                }
            });
            return rules;
        },

        _check: function( field ) {
            var method, rule, result,
                val = field.value,
                rules = this._rules( field ),
                flag = this._getFlag( field );
            if(!("required" in rules) && (val == null || val == '')) return true;
            for ( method in rules ) {
                rule = {
                    method: method,
                    param: rules[ method ]
                };

                result = this.methods[ method ].call( this, val, field, rule.param );
                $.data( field, "currentRule", rule );

                if ( result === "pending" ) {
                    return false;
                }

                if ( !result ) {
                    this._messages( field, rule );
                    return false;
                }
            }

            if ( this.errorMap[flag] ) {
                delete this.errorMap[ flag ];
            }
            return true;
        },

        checkForm: function() {
            if ( !this.errorMap ) {
                this.errorMap = {};
            }
            for ( var i = 0, elements = this.elements, flag; elements[i]; i++ ) {
                flag = this._getFlag( elements[i] );
                if ( !$(elements[i]).hasClass("yhui-validate") ) {
                    this._check( elements[i] );
                }
            }
            var valiflag = this._valid();
            if(!valiflag) this._parseErrorField();
            return valiflag;
        },

        _checkField: function( field ) {
            if ( this.errorMap ) {
                if ( $.data( field, "currentRule" ) && $.data( field, "currentRule" ).method === "remote" ) {
                    this._check( field );
                    return;
                }

                var flag = this._getFlag( field );
                if ( this._check(field) ) {
                    this._cancelError( field );
                    if ( this.errorMap[flag] ) {
                        delete this.errorMap[flag];
                    }
                } else {
                    var rule = $.data( field, "currentRule" );
                    var message = this._messages( field, rule );
                    this._showError( field );
                    this._tip( field, message );
                    if ( !this.errorMap[flag] ) {
                        this.errorMap[flag] = {
                            element: field,
                            message: message
                        }
                    }
                }
            }
        },

        _startRequest: function( field ) {
            if ( !this.pending ) {
                this.pending = {};
                this.xhr = {};
            }

            var flag = this._getFlag( field );
            this.pending[ flag ] = field;
            var $pending = $( "#yhui-validate-pending-" + flag );
            if ( !$pending.length ) {
                $( "<span></span>", {
                    id: "yhui-validate-pending-" + flag,
                    "class": "yhui-validate-pending"
                }).appendTo( this.document[0].body )
                    .position({
                        of: field,
                        at: "right center",
                        my: "right-3 center"
                    });
            }
        },

        _stopRequest: function( field, valid, flag ) {
            delete this.pending[ flag ];
            $( "#yhui-validate-pending-" + flag ).remove();
            if ( valid && $.isEmptyObject(this.pending)
                && $.isEmptyObject(this.errorMap)
                && $.isEmptyObject(this.remoteErrorMap) ) {
                this.formSubmit = true;
                this.remotedAll && this.options.validateOnSubmit && this.element.submit();
                this.remotedAll = true;
            }
        },

        _messages: function( field, rule, remote ) {
            var message = this._getMessages( field, rule.method, rule.param );
            if ( !remote ) {
                this.errorMap[ this._getFlag(field) ] = {
                    element: field,
                    message: message
                };
            }
            return message;
        },

        _getMessages: function( field, method, param ) {
            var message;
            if ( message = $( field ).attr(method+"-msg") ) {
                return $.yhui.print( message, param );
            }
            
            if ( this.options.messages && (message=this.options.messages[this._getFlag(field)]) ) {
                if ( typeof message === "string" ) {
                    return $.yhui.print( message, param );
                } else if ( message = message[method] ) {
                    return $.yhui.print( message, param );
                }
            }
            return $.yhui.print( this.messages[ method ] || "请定义提示语", param );
        },

        _parseErrorField: function() {
            var elem, flag, tipFlag,
                i = 0,
                elements = this.elements,
                len = elements.length;
            for ( ; i < len; i++ ) {
                elem = elements[i];
                flag = this._getFlag( elem );
                if ( flag in this.errorMap ) {
                    this._showError( elem, this.errorMap[flag].message );
                    if ( !tipFlag ) {
                        tipFlag = true;
                        this._tip( elem, this.errorMap[flag].message );
                    }
                }
            }
        },

        _showError: function( field, message ) {
            var $dropDown = $(field).closest(".yhui-dropdown");
            if ( !$dropDown.length ) {
                $( field ).addClass( "yhui-validate" );
            } else {
                $dropDown.addClass( "yhui-validate" );
            }
            if ( message ) {
                $.data( field, "message", message );
            }
        },
        callMethod : function(name,val,field,param){//新增的调用methods中的校验方法，供外部自定义校验时可以调用里面的内部校验方法
        	return this.methods[name].call( this, val, field, param);
        },
        remove : function(){//新增的移除错误提示信息及提示框，供外部对象调用
        	if (this.tip ) this.tip.hide();
        	$("[data-hastip]").removeAttr("data-hastip");
        	$(".yhui-validate").removeClass("yhui-validate");
        },
        _tip: function( field, message ) {
            if ( !$.isEmptyObject(this.errorMap) || !$.isEmptyObject(this.remoteErrorMap) ) {
                if ( !this.tip ) {
                	//此处加了z-index，让提示层显示在最上层
                    this.tip = $( "<div class='yhui-validate-tip' style='z-index:99999999'></div>" ).hide();
                    this.tipContent = $( "<div class='yhui-validate-tip-content'></div>" );
                    this.tipList = $( "<p class='yhui-validate-tip-errorlist'></p>" ).html( message ).appendTo( this.tipContent );
                    this.tip
                        .append( this.tipContent )
                        .appendTo( document.body );
                } else {
                    this.tipList.html( message );
                }

                $( this.hasTipElement ).removeAttr("data-hastip");
                this.hasTipElement = field;
                $( this.hasTipElement ).attr( "data-hastip", "hastip" );
                var ofe = field;
                if(field.type=='hidden') ofe = $(field).parent();
                this.tip
                    .data( "target", field )
                    .css( { top: 0, left: 0 } )
                    .show()
                    .position( $.extend(this.options.position, {
                        of: ofe,
                        collision: "fit"
                    }));
            }
        },

        _cancelError: function( field ) {
            var $field = $( field ),
                $dropDown = $(field).closest(".yhui-dropdown");
            if ( $field.attr("data-hastip") ) {
                this.tip.hide();
            }
            if ( $dropDown.length ) {
                $field = $dropDown;
            }
            $field.removeClass( "yhui-validate" );
        },

        _getFlag: function( field ) {
            var ret;
            if ( !this._checkable(field) ) {
                ret = field.name || field.id;
            } else {
                ret = $( field ).find( "input" )[0].name;
            }
            return ret;
        },

        _checkable: function( field ) {
            return field.className.indexOf( "yhui-form-checkable" ) > -1;
        },

        _findByName: function( name ) {
            return this.element.find('[name="' + name + '"]');
        }
    });
})( jQuery );
