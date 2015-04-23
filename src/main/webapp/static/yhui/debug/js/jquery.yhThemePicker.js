/*!
 * YHUI yhThemePicker @VERSION
 *
 * Depends:
 *  jquery
 *  yhCore
 */
(function( $ ){
    $.yhui.yhThemePicker = function( $holder ) {
        var selectedIndex,
            $themePicker = $( "<select>" +
                "<option value = 'skinOrange'>蜜橘橙</option>" +
                "<option value = 'skinBlue'>天空蓝</option>" +
                "</select>" ),
            theme = $.yhui.cookie( "yhui-themepicker" );

        if ( theme ) {
            var i = 0, l = $themePicker[0].options.length;
            for ( ; i < l; i++ ) {
                if ( $themePicker[0].options[i].value === theme ) {
                    $themePicker[0].options[i].selected = true;
                }
            }
        }

        selectedIndex = $themePicker[0].selectedIndex;
        $themePicker
            .appendTo( $holder )
            .on( "change", function() {
            if ( confirm( "* 要刷新页面才能更换皮肤\n\n* 这个过程会关闭当前打开的选项卡\n\n* 是否刷新？" ) ) {
                $.yhui.cookie( "yhui-themepicker", this.options[ this.selectedIndex ].value, { expires: 100 } );
                location.reload( true );
            } else {
                this.selectedIndex = selectedIndex;
            }
        });
    };
})( jQuery );