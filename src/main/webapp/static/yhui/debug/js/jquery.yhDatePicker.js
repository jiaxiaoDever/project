/*!
 * YHUI yhDatePicker @VERSION
 *
 * Depends:
 *  jquery.ui.core
 *  jquery.ui.widget
 *  jquery.mousewheel.js (possible)
 */
(function( $ ){
    var idIncrement = 0,
        showInstance = null;
    $.widget( "yhui.yhDatePicker", {
        version: "@VERSION",
        defaultElement: "<input>",
        options: {
            format: "yyyy-MM-dd",
            maxDate: null,
            minDate: null,
            selectedDate: null,
            showTime: false,    //Option Values: "hour" "minute" "second" true false

            //callback
            hide: null
        },
        _CONSTS: {
            TF: "HH:mm:ss",
            ROW : 6,
            COL : 7,
            DISABLE: "yhui-datepicker-disable",
            TODAY: "yhui-datepicker-today",
            WBEGIN : "yhui-datepicker-weekbegin",
            WEND : "yhui-datepicker-weekend",
            PMON : "yhui-datepicker-prevmonth",
            CMON : "yhui-datepicker-currentmonth",
            NMON : "yhui-datepicker-nextmonth",
            SELECTED : "yhui-datepicker-selecteddate",
            TIME: "yhui-datepicker-time",
            dayNames: [ "日", "一", "二", "三", "四", "五", "六" ],
            monthNames: [ "一月", "二月", "三月", "四月", "五月", "六月",
                "七月", "八月", "九月", "十月", "十一月", "十二月" ]
        },
        _create: function() {
            var that = this;
            this.id = "yhui-datepicker-" + idIncrement++;
            this.element
                .val( "" )
                .addClass( "yhui-form-text yhui-datepicker-holder" )
                .attr( "hasDatePicker", this.id )
                .on( that._namespace("focus"), function() {
                    that._parse();
                });

            this._parseData();
            //this._parseDate();
            if ( this.options.selectedDate ) this._setValue();
        },

        _parse: function( flag ) {
            this._parseDom();
            flag || this.show();
        },

        _parseData: function() {
            var drawDate = new Date(),
                sDate = this._parseDate( this.options.selectedDate, drawDate ),
                selectedDate = null,
                time = null;

            if ( sDate ) {
                if ( typeof sDate === "string" ) {
                    selectedDate = Globalize.parseDate( sDate, this.options.format );
                } else if ( sDate.getTime ) {
                    selectedDate = sDate;
                }
            }

            if ( selectedDate ) {
                drawDate = this._cloneDate( selectedDate );
            }


            if ( this.options.showTime ) {
                time = this._parseTimeData();
            }

            this.info = {
                drawDate: drawDate,
                selectedDate: selectedDate,
                today: new Date(),
                time: time
            };
        },

        _parseTimeData: function() {
            var time = null,
                showTime = this.options.showTime,
                type = typeof showTime,
                today = new Date();

            if ( type === "boolean" ) {
                time = new Date( 0, 0, 0, today.getHours(), today.getMinutes(), today.getSeconds() );
            } else {
                if ( type === "string" ) {
                    var timeArray = showTime.split( ":" );
                    if ( timeArray.length === 1 ) {
                        this.disableMinutes = true;
                        this.disableSeconds = true;
                        time = new Date( 0, 0, 0, timeArray[0], 0, 0);
                    }
                    if ( timeArray.length === 2 ) {
                        this.disableSeconds = true;
                        time = new Date( 0, 0, 0, timeArray[0], timeArray[1], 0 );
                    }
                    if ( timeArray.length === 3 ) {
                        time = new Date( 0, 0, 0, timeArray[0], timeArray[1], timeArray[2] );
                    }
                }
            }
            return time;
        },

        _parseDom: function() {
            if ( !this.hasDatePicker ) {
                this._createFrame();
                this._events();
                this._refresh();
            }
        },

        _events: function() {
            var that = this;
            var iframes="";
            this.window
                .on( this._namespace("resize"), function() {
                    that._updatePosition();
                });
            if(this.document.find("iframe").get(0)){
            	iframes=this.document.find("iframe").get(0).contentWindow.document;
            		}
            this.document.add(iframes)
                .on( this._namespace("click"), function() {
                    that.datepicker.is(":visible") && that.hide();
                });

            this.element
                .on( this._namespace("click"), function(e) {
                    e.stopPropagation();
                });

            this.datepicker
                .on( this._namespace("click"), function(e) {
                    var role = $( e.target ).attr( "role" );
                    if ( !/^(?:yearinput|monthinput|yearprev|yearnext)$/.test(role) ) {
                        that._closeList();
                    }
                    e.stopPropagation();
                })
                .on( this._namespace("mousewheel"), function( e, delta ) {
                    if ( that.options.showTime ) {
                        that._refreshTime( delta );
                        that.changeTime = true;
                    }
                })
                .on( this._namespace("mousedown mouseup"), "a,td", function(e) {
                    if ( this.className.indexOf("disable") > -1 ) return;

                    var $this = $( this ),
                        role = $this.attr("role");

                    switch( role ) {
                        case "prev":
                        case "next":
                        case "yearprev":
                        case "yearnext":
                            $this.toggleClass( "yhui-state-actived" );
                            break;
                        case "today":
                            $this.toggleClass( "yhui-datepicker-btntoday-hover" );
                            break;
                        case "step":
                            that._step( e, this, this.className.indexOf("up") > -1 ? 1 : -1 );
                            break;
                    }
                })
                .on( this._namespace("mouseenter mouseleave"), "a,td,div,input:not([disabled])", function(e) {
                    if ( this.className.indexOf("disable") > -1 ) return;

                    var $this = $( this ),
                        role = $this.attr("role" );

                    switch ( role ) {
                        case "prev":
                        case "next":
                            $this.toggleClass( "yhui-state-hover" );
                            if ( e.type ==="mouseleave" ) {
                                $this.removeClass("yhui-state-actived");
                            }
                            break;
                        case "calendar":
                        case "yearlist":
                        case "monthlist":
                        case "yearprev":
                        case "yearnext":
                        case "hour":
                        case "second":
                        case "minute":
                        case "step":
                            if ( (role === "monthlist" || role === "yearlist") && $this.hasClass("yhui-state-actived") ) {
                                return;
                            }
                            $this.toggleClass( "yhui-state-hover" );
                            break;
                        case "close":
                            if ( e.type === "mouseleave" ) {
                                that._closeList();
                            }
                            break;
                        case "today":
                            $this.toggleClass( "yhui-datepicker-btntoday-hover" );
                            break;
                    }
                })
                .on( this._namespace("keydown"), "input", function(e) {
                    e.preventDefault();
                })
                .on( this._namespace("click"), "a,td,input:not([disabled]),button", function(e) {
                    e.preventDefault();
                    if ( this.className.indexOf("disable") > -1 ) return;

                    var $this = $( this ),
                        role = $this.attr("role" );

                    switch ( role ) {
                        case "next":
                        case "prev":
                            var temp = role === "next" ? 1 : -1;
                            that._adjust( that.info.drawDate, temp );
                            that._refresh();
                            break;
                        case "today":
                            that._today();
                            break;
                        case "calendar":
                            that._calendar( this );
                            break;
                        case "monthinput":
                            that._monthinput();
                            break;
                        case "yearinput":
                            that._yearinput();
                            break;
                        case "monthlist":
                            that._monthlist( this );
                            break;
                        case "yearlist":
                            that._yearlist( this );
                            break;
                        case "yearprev":
                        case "yearnext":
                            var isPrev = role === "yearprev",
                                increment = isPrev ? -5 : 6,
                                year = that.yearlist.find("tr:last>td")[ isPrev ? "first" : "last" ]().text();
                                that._yearinput( parseInt( year ) + increment );
                            break;
                        case "clear":
                            that._clear();
                            break;
                        case "confirm":
                            if ( that.options.showTime && that.changeTime && that._setValue() === false ) return;
                            that.hide();
                            that.element.blur();
                            break;
                        case "hour":
                        case "minute":
                        case "second":
                            $(this).addClass("yhui-datepicker-focus").siblings("input").removeClass("yhui-datepicker-focus");
                            break;
                        default:
                            //$.yhui.log( "click event default" );
                    }
                });
        },

        _namespace: function( event ) {
            return $.yhui.parseEventType( event, this.eventNamespace );
        },

        _cloneDate: function( date ) {
            if ( !date ) return;
            return new Date( date.getFullYear(), date.getMonth(), date.getDate(),
                                date.getHours(), date.getMinutes(), date.getSeconds() );
        },

        _refresh: function() {
            this._refreshHeader();
            this._refreshMain();
            this.options.showTime && this._refreshTimePicker();
        },

        _refreshHeader: function() {
            var year = this.info.drawDate.getFullYear(),
                month = this.info.drawDate.getMonth();

            this.yearinput.val( year );
            this.monthinput.val( this._CONSTS.monthNames[month] );
        },

        _refreshMain: function() {
            var tdContent, tdClass, m,
                i = 0, j = 0, inDay = 0, compareMonth = -1, isNextMonth = false,
                htmlArr = ["<table><thead><tr>"],
                info = this.info,
                drawMonth = info.drawDate.getMonth(), drawYear = info.drawDate.getFullYear(),
                currentDay = info.today.getDate(),
                minDate = this._parseDate( this.options.minDate, info.selectedDate || info.today ),
                maxDate = this._parseDate( this.options.maxDate, info.selectedDate || info.today ),
                firstDay = this._firstDayOfMonth( drawYear, drawMonth ),
                numOfDays = this._daysInMonth( drawYear, drawMonth ),
                prevNumOfDays = this._daysInMonth( drawYear, drawMonth - 1 ),
                isPrevMonth = ( firstDay > 0 ),
                consts = this._CONSTS;


            this._checkedPrevOrNext( drawYear, drawMonth );

            for ( ; i < consts.COL; i++ ) {
                htmlArr.push( "<th>", consts.dayNames[i], "</th>" );
            }
            htmlArr.push( "</tr></thead><tbody>" );

            for ( ; j < consts.ROW; j++ ) {
                htmlArr.push( "<tr>" );

                for ( m = 0; m < consts.COL; m++ ) {
                    if ( isPrevMonth ) {
                        tdClass = consts.PMON;
                        tdContent = (prevNumOfDays - firstDay + m + 1);
                        compareMonth = drawMonth - 1;
                    } else if ( isNextMonth ) {
                        tdClass = consts.NMON;
                        tdContent = ++inDay;
                        compareMonth = drawMonth + 1;
                    } else {
                        tdClass = consts.CMON;
                        tdContent = ++inDay;
                        compareMonth = drawMonth;
                    }

                    var compare = new Date( drawYear, compareMonth, tdContent ).getTime();
                    if ( minDate && minDate.getTime() > compare ) {
                        tdClass = tdClass + " " + consts.DISABLE;
                    }

                    if ( maxDate && maxDate.getTime() < compare ) {
                        tdClass = tdClass + " " + consts.DISABLE;
                    }

                    //week begin
                    if ( m === 0 ) tdClass = tdClass + " " + consts.WBEGIN;
                    //week end
                    if ( m === 6 ) tdClass = tdClass + " " + consts.WEND;
                    //today
                    if ( currentDay === inDay
                            && !isPrevMonth
                            && !isNextMonth
                            && info.today.getMonth() === drawMonth
                            && info.today.getFullYear() === drawYear ) {
                        tdClass = tdClass + " " + consts.TODAY;
                    }
                    //selectedDay
                    if ( info.selectedDate && (inDay === info.selectedDate.getDate()) && !isNextMonth ) tdClass = tdClass + " " + consts.SELECTED;

                    htmlArr.push( "<td role='calendar' class = '"+ tdClass +"'>", tdContent, "</td>" );

                    if ( tdContent === prevNumOfDays ) {
                        isPrevMonth = false;
                    }

                    if ( inDay >= numOfDays ) {
                        inDay = 0;
                        isNextMonth = true;
                    }
                }

                htmlArr.push( "</tr>" );
            }

            htmlArr.push( "</tbody></table>" );

            this.main.html( htmlArr.join("") );
        },

        _refreshTimePicker: function() {
            var time = this.info.time,
                $input = this.timepicker.find("input");
            if ( time ) {
                this.disableSeconds && $input.eq(2).prop( "disabled", true );
                this.disableMinutes && $input.eq(1).prop( "disabled", true );
                $.each( Globalize.format(time, this._CONSTS.TF).split(":"), function( index, value ) {
                    $input.eq( index ).val( value );
                });
            }
        },

        _refreshTime: function( delta ) {
            var time = this.info.time,
                $input = this.timepicker.find("input.yhui-datepicker-focus"),
                role = $input.attr("role"),
                val = parseInt( $input.val(), 10),
                fillZero = function( num ) {
                    num = num + "";
                    if ( num.length === 1 ) {
                        return "0" + num;
                    } else {
                        return num;
                    }
                };

            val += delta;
            switch ( role ) {
                case "hour":
                    if ( val > 23 ) val = 0;
                    if ( val < 0 ) val = 23;
                    time.setHours( val );
                    break;
                case "minute":
                case "second":
                    if ( val > 59 ) val = 0;
                    if ( val < 0 ) val = 59;
                    time[ role === "minute" ? "setMinutes" : "setSeconds"]( val );
                    break;
            }
            $input.val( fillZero(val) );
        },

        _step: function( e, a, delta ) {
            var that = this;
            if ( e.type === "mousedown" ) {
                $(a).addClass( "yhui-state-actived" );
                this._repeat( null, function() {
                    that._refreshTime( delta );
                });
            } else {
                clearTimeout( this.timer );
                $(a).removeClass( "yhui-state-actived" );
            }
        },

        _repeat: function( delay, fun ) {
            delay = delay || 500;
            var that = this;
            that.timer = that._delay(function() {
                that._repeat( 100, fun );
            }, delay );
            fun && fun.apply( null, arguments );
        },

        _createFrame: function() {
            this.datepicker = $("<div id = '" + this.id + "' class = 'yhui-datepicker'>"
                + "<div class = 'yhui-datepicker-head' >"
                + "<a href = '#' class = 'yhui-datepicker-prev' role = 'prev' ><span class = 'ui-icon ui-corner-all ui-icon-triangle-1-w' ></span></a>"
                + "<input role = 'yearinput' type = 'text' class = 'yhui-datepicker-changeyear' />"
                + "<span class = 'yhui-datepicker-split'></span>"
                + "<input role = 'monthinput' type = 'text' class = 'yhui-datepicker-changemonth' />"
                + "<a href = '#' class = 'yhui-datepicker-next' role = 'next' ><span class = 'ui-icon ui-corner-all ui-icon-triangle-1-e' ></span></a>"
                + "<a href = '#' class = 'yhui-datepicker-btntoday' role = 'today'>今天</a>"
                + "</div><div class = 'yhui-datepicker-main' ></div>"
                + "<div class = 'yhui-datepicker-control' >"
                + "<button role = 'confirm'>确定</button><button role = 'clear'>清空</button>"
                + "</div>"
                + "</div>").hide().appendTo( this.document[0].body );

            var $temp = this.datepicker.children( "div" );
            this.header = $temp.first();
            this.yearinput = this.header.find(".yhui-datepicker-changeyear" ).eq(0);
            this.monthinput = this.header.find(".yhui-datepicker-changemonth" ).eq(0);
            this.prev = this.header.find(".yhui-datepicker-prev").eq(0);
            this.next = this.header.find(".yhui-datepicker-next").eq(0);
            this.today = this.header.find(".yhui-datepicker-btntoday").eq(0);
            this.main = $temp.eq(1);
            this.buttonPane = $temp.eq(2);
            this.datepicker
                .disableSelection()
                .hide()
                .append( this.header, this.main, this.buttonPane )
                .appendTo( this.document[0].body );

            this.hasDatePicker = true;

            if ( this.options.showTime ) {
                this._createTimePicker();
            }
        },

        _createTimePicker: function() {
            this.timepicker =
                $("<div class = 'yhui-datepicker-time'><div class = 'yhui-datepicker-timeinner'>"
                    + "<input type = 'text' role='hour' class = 'yhui-datepicker-hour yhui-datepicker-focus' /><span>:</span>"
                    + "<input type = 'text' role='minute' class = 'yhui-datepicker-minute' /><span>:</span>"
                    + "<input type = 'text' role='second' class = 'yhui-datepicker-second' />"
                    + "<a href = '#' class = 'yhui-datepicker-up' role = 'step' ><span class = 'ui-icon ui-icon-triangle-1-n'></span></a>"
                    + "<a href = '#' class = 'yhui-datepicker-down' role = 'step' ><span class = 'ui-icon ui-icon-triangle-1-s'></span></a>"
                    + "</div></div>").insertBefore( this.buttonPane );
        },

        _firstDayOfMonth: function( year, month ) {
            return new Date( year, month, 1 ).getDay();
        },

        _daysInMonth: function( year, month ) {
            return 32 - new Date( year, month, 32 ).getDate();
        },

        _monthNameToIndex: function( name ) {
            if ( name.indexOf("月") === -1 ) {
                name = name + "月";
            }
            return $.inArray( name, this._CONSTS.monthNames );
        },

        _parseDate: function( date, primary  ) {
            if ( date && date.getTime ) return date;

            var r = /(?:([\+,-]\d+)y)?(?:([+,-]\d+)M)?(?:([+,-]\d+)d)?/;
            primary = primary || new Date();
            if ( typeof date === "string" ) {
                if ( /y|m|d/i.test(date) ) {
                    var temp = r.exec( date),
                        year = primary.getFullYear() + (parseInt( temp[1] ) || 0),
                        month = primary.getMonth() + (parseInt( temp[2] ) || 0),
                        day = primary.getDate() + (parseInt( temp[3] ) || 0);
                    if ( date.indexOf("d") === -1 ) {
                        day = Math.max( 1, Math.min( day, this._daysInMonth( year, month ) ) );
                    }
                    return new Date( year, month, day, primary.getHours(), primary.getMinutes(), primary.getSeconds() );
                } else {
                    return Globalize.parseDate( date, this.options.format );
                }
            }

        },

        _checkedPrevOrNext: function( drawYear, drawMonth ) {
            var minDate = this._parseDate( this.options.minDate ),
                maxDate = this._parseDate( this.options.maxDate );

            if ( !minDate && !maxDate ) {
                return this.prev.add(this.next).removeClass( "ui-state-disabled" );
            }

            var minTime, maxTime,
                drawTime = new Date( drawYear, drawMonth ).getTime();

            if ( minDate ) {
                minTime = new Date( minDate.getFullYear(), minDate.getMonth() ).getTime();
                if ( minTime === drawTime ) {
                    this.prev.addClass( "ui-state-disabled" ).removeClass("ui-state-hover");
                } else {
                    this.prev.removeClass( "ui-state-disabled" );
                }
            }

            if ( maxDate ) {
                maxTime = new Date( maxDate.getFullYear(), maxDate.getMonth() ).getTime();
                if ( maxTime === drawTime ) {
                    this.next.addClass( "ui-state-disabled" ).removeClass( "ui-state-hover" );
                } else {
                    this.next.removeClass( "ui-state-disabled" );
                }
            }
        },

        _checkToday: function() {
            var maxDate = this._parseDate( this.options.maxDate ),
                minDate = this._parseDate( this.options.minDate ),
                t = new Date(),
                today = new Date( t.getFullYear(), t.getMonth(), t.getDate() ).getTime();

            if ( maxDate ) {
                if ( today > maxDate.getTime() ) {
                    this.today.addClass( "ui-state-disabled" );
                    return;
                } else {
                    this.today.removeClass( "ui-state-disabled" );
                }
            }

            if ( minDate ) {
                if ( today < minDate.getTime() ) {
                    this.today.addClass( "ui-state-disabled" );
                } else {
                    this.today.removeClass( "ui-state-disabled" );
                }
            }
        },

        _updatePosition: function() {
            var reset = { top: 0, left: 0 };
            this.datepicker
                .css( reset )
                .position({
                    of: this.element,
                    at: "left bottom",
                    my: "left top",
                    collision: "flipfit"
                });
        },

        _calendar: function( td ) {
            var increment = 0,
                se = this._CONSTS.SELECTED,
                draw = this.info.drawDate,
                year = draw.getFullYear(),
                month = draw.getMonth();

            if ( td.className.indexOf("prev") > -1 ) {
                increment = -1;
            }
            if ( td.className.indexOf("next") > -1 ) {
                increment = 1;
            }

            this.main.find("td").removeClass( se );
            $( td ).addClass( se );

            this._adjust( this.info.drawDate, increment );
            this.info.selectedDate = new Date( year, month, td.innerHTML );
            this._setValue();
            if ( increment ) {
                this._refresh();
            }
        },

        _adjust: function( date, delta, yearOrMonth ) {
            var y, m, d, daysInMonth;
            if ( typeof delta === "number" ) {
                y = date.getFullYear();
                m = date.getMonth() + delta;
                d = date.getDate();
                daysInMonth = this._daysInMonth( y, m );
                date.setMonth( m, Math.min(d, daysInMonth) );
            } else {
                if ( delta === "y" ) {
                    m = date.getMonth();
                    d = date.getDate();
                    daysInMonth = this._daysInMonth( yearOrMonth, m );
                    date.setFullYear( yearOrMonth );
                    date.setMonth( m, Math.min(d, daysInMonth) );
                } else if ( delta === "M" ) {
                    y = date.getFullYear();
                    d = date.getDate();
                    daysInMonth = this._daysInMonth( y, yearOrMonth );
                    date.setMonth( yearOrMonth, Math.min(d, daysInMonth) );
                }
            }
        },

        _setValue: function() {
            var time,
                date = Globalize.format(this.info.selectedDate, this.options.format);
            if ( !date ) {
                alert( "请选择一个日期" );
                return false;
            }
            if ( this.info.time ) {
                time = Globalize.format( this.info.time, this._CONSTS.TF );
                date = date + " " + time;
            }
            this.element.val( date );
        },

        _today: function() {
            var info = this.info,
                today = this.info.today,
                month = today.getMonth(),
                year = today.getFullYear();

            info.selectedDate = this._cloneDate( today );
            info.drawDate.setFullYear( year );
            info.drawDate.setMonth( month );
            this._setValue();
            this._refresh();
        },

        _monthinput: function() {
            if ( !this.monthlist ) {
                var monthlist = [ "<div role='close' class='yhui-datepicker-month ui-widget-content'><table>" ];
                for ( var i = 0, l = this._CONSTS.monthNames.length; i < l; i++ ) {
                    i % 2 || monthlist.push("<tr>");
                    monthlist.push("<td role='monthlist'>", this._CONSTS.monthNames[i].substring(0,2), "</td>");
                    (i + 1) % 2 || monthlist.push("</tr>");
                }
                monthlist.push( "</table></div>" );
                this.monthlist =
                    $( monthlist.join("") )
                        .appendTo( this.header )
                        .show();
           } else {
                this.monthlist.show();
            }
            this.monthlist.find("td" ).removeClass("yhui-state-actived")
                .eq( this.info.drawDate.getMonth() ).addClass("yhui-state-actived" );
            this.header.addClass( "yhui-datepicker-focusmonth" ).removeClass( "yhui-datepicker-focusyear" );
            this.yearlist && this.yearlist.hide();
        },

        _monthlist: function( td ) {
            if ( $( td ).hasClass("yhui-state-actived") ) return;
            var month = this._monthNameToIndex( td.innerHTML );
            this._adjust( this.info.drawDate, "M", month );
            this._refresh();
            this._closeList();
        },

        _yearinput: function( year ) {
            if ( !this.yearlist ) {
                var yearlist =
                    "<div role='close' class = 'yhui-datepicker-year ui-widget-content'>" +
                        "<div>" + this._createYearList() + "</div>" +
                        "<a href = '#' role = 'yearprev' class = 'yhui-datepicker-yearprev'>&larr;</a>" +
                        "<a href = '#' role = 'yearnext' class = 'yhui-datepicker-yearprev'>&rarr;</a>" +
                    "</div>";
                this.yearlist = $( yearlist ).appendTo( this.header ).show();
            } else {
                this.yearlist.find( "div" ).html( this._createYearList( year ) ).end().show();
            }
            this.header.addClass( "yhui-datepicker-focusyear" ).removeClass( "yhui-datepicker-focusmonth" );
            this.monthlist && this.monthlist.hide();
        },

        _yearlist: function( td ) {
            if ( $( td ).hasClass("yhui-state-actived") ) return;
            var year = parseInt( td.innerHTML, 10 );
            this._adjust( this.info.drawDate, "y", year );
            this._refresh();
            this._closeList();
        },

        _createYearList: function( y ) {
            var i = 0,
                year = y || this.info.drawDate.getFullYear(),
                tableYear = ["<table>"];

            for ( ; i < 5; i ++ ) {

                tableYear.push( "<tr>" );
                tableYear.push( "<td role='yearlist'>", year - i - 1, "</td>" );
                tableYear.push( "<td" );
                if ( i === 0 && year === this.info.drawDate.getFullYear() ) {
                    tableYear.push(" class='yhui-state-actived'");
                }
                tableYear.push( " role='yearlist'>", year + i, "</td>" );
                tableYear.push( "</tr>" );
            }
            tableYear.push( "</table>" );
            return tableYear.join("");
        },

        _clear: function() {
            this.hide();
            this.element.val("").blur();
            this._parseData();
            this._refresh();
        },

        _setOption: function( key, value ) {
            if ( !this.datepicker ) {
                this._parse( true );
            }
            if ( key === "selectedDate" ) {
                this.options.selectedDate = value;
                this._parseData();
                this._refresh();
                this._setValue();
                return;
            }

            this._super( key, value );

            if ( key === "minDate" || key === "maxDate" ) {
                this._refresh();
            }
        },

        show: function() {
            this._checkToday();
            this.datepicker.show();

            if ( !this.justShow ) {
                this._updatePosition();
                this.justShow = true;
            }

            if ( showInstance && showInstance.id !== this.id ) {
                showInstance.hide();
            }

            if ( !showInstance || showInstance.id !== this.id ) {
                showInstance = this;
            }
        },

        _closeList: function() {
            this.monthlist && this.monthlist.hide();
            this.yearlist && this.yearlist.hide();
            this.header.removeClass( "yhui-datepicker-focusmonth yhui-datepicker-focusyear" );
        },

        hide: function() {
            this._closeList();
            this.datepicker.hide();
            this._delay(function(){
                this._trigger( "hide", null, { input: this.element } );
            }, 20);

        },

        _destroy: function() {
            this.element
                .removeClass( "yhui-datepicker-holder" )
                .removeAttr( "hasDatePicker" )
                .off( this.eventNamespace );
            if ( this.datepicker ) {
                this.datepicker
                    .off( this.eventNamespace )
                    .remove();
            }
        },

        getSelected: function() {
            var time,
                selected = this.info.selectedDate;

            if ( time = this.info.time ) {
                selected.setHours( time.getHours() || 0 );
                selected.setMinutes( time.getMinutes() || 0 );
                selected.setSeconds( time.getSeconds() || 0 );
            }
            return selected;
        }
    });
})(jQuery);