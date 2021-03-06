{*
/**
 *
 * SugarCRM Community Edition is a customer relationship management program developed by
 * SugarCRM, Inc. Copyright (C) 2004-2013 SugarCRM Inc.
 *
 * SuiteCRM is an extension to SugarCRM Community Edition developed by SalesAgility Ltd.
 * Copyright (C) 2011 - 2016 SalesAgility Ltd.
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Affero General Public License version 3 as published by the
 * Free Software Foundation with the addition of the following permission added
 * to Section 15 as permitted in Section 7(a): FOR ANY PART OF THE COVERED WORK
 * IN WHICH THE COPYRIGHT IS OWNED BY SUGARCRM, SUGARCRM DISCLAIMS THE WARRANTY
 * OF NON INFRINGEMENT OF THIRD PARTY RIGHTS.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
 * details.
 *
 * You should have received a copy of the GNU Affero General Public License along with
 * this program; if not, see http://www.gnu.org/licenses or write to the Free
 * Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 * 02110-1301 USA.
 *
 * You can contact SugarCRM, Inc. headquarters at 10050 North Wolfe Road,
 * SW2-130, Cupertino, CA 95014, USA. or at email address contact@sugarcrm.com.
 *
 * The interactive user interfaces in modified source and object code versions
 * of this program must display Appropriate Legal Notices, as required under
 * Section 5 of the GNU Affero General Public License version 3.
 *
 * In accordance with Section 7(b) of the GNU Affero General Public License version 3,
 * these Appropriate Legal Notices must retain the display of the "Powered by
 * SugarCRM" logo and "Supercharged by SuiteCRM" logo. If the display of the logos is not
 * reasonably feasible for  technical reasons, the Appropriate Legal Notices must
 * display the words  "Powered by SugarCRM" and "Supercharged by SuiteCRM".
 */
*}

{{sugar_include type="smarty" file=$headerTpl}}
{sugar_include include=$includes}
<div>
    {*display tabs*}
    {{counter name="tabCount" start=-1 print=false assign="tabCount"}}
    <ul class="nav nav-tabs">
        {{if $useTabs}}
            {{foreach name=section from=$sectionPanels key=label item=panel}}
                {{capture name=label_upper assign=label_upper}}{{$label|upper}}{{/capture}}
                {* if tab *}
                {{if (isset($tabDefs[$label_upper].newTab) && $tabDefs[$label_upper].newTab == true)}}
                {*if tab display*}
                    {{counter name="tabCount" print=false}}
                    {{if $tabCount == '0'}}
                        <li role="presentation" class="active">
                            <a id="tab{{$tabCount}}" href="#tab-content-{{$tabCount}}" data-toggle="tab" class="hidden-xs">
                                {sugar_translate label='{{$label}}' module='{{$module}}'}
                            </a>
                            <a id="xstab{{$tabCount}}" href="#" class="visible-xs first-tab-xs dropdown-toggle" data-toggle="dropdown">
                                {sugar_translate label='{{$label}}' module='{{$module}}'}
                            </a>
                            <ul id="first-tab-menu-xs" class="dropdown-menu">
                                {{counter name="tabCountXS" start=-1 print=false assign="tabCountXS"}}
                                {{foreach name=sectionXS from=$sectionPanels key=label item=panelXS}}
                                {{counter name="tabCountXS" print=false}}
                                <li role="presentation">
                                    <a id="tab{{$tabCountXS}}" href="#tab-content-{{$tabCountXS}}" data-toggle="tab" onclick="changeFirstTab(this, 'tab-content-{{$tabCountXS}}');">
                                        {sugar_translate label='{{$label}}' module='{{$module}}'}
                                    </a>
                                </li>
                                {{/foreach}}
                            </ul>
                        </li>
                    {{else}}
                        <li role="presentation" class="hidden-xs">
                            <a id="tab{{$tabCount}}" href="#tab-content-{{$tabCount}}" data-toggle="tab">
                                {sugar_translate label='{{$label}}' module='{{$module}}'}
                            </a>
                        </li>
                    {{/if}}
                {{else}}
                    {* if panel skip*}
                {{/if}}
            {{/foreach}}
        {{/if}}
        {if $config.enable_action_menu}
        <li id="tab-actions" class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">{{$APP.LBL_LINK_ACTIONS}}</a>
            {{include file="themes/SuiteP/include/DetailView/actions_menu.tpl"}}
        </li>
        {/if}
    </ul>

    <div class="clearfix"></div>
    {{if $useTabs}}
        <div class="tab-content">
    {{else}}
        <div class="tab-content" style="padding: 0; border: 0;">
    {{/if}}
        {* Loop through all top level panels first *}
        {{counter name="tabCount" start=0 print=false assign="tabCount"}}
        {{if $useTabs}}
            {{foreach name=section from=$sectionPanels key=label item=panel}}
            {{capture name=label_upper assign=label_upper}}{{$label|upper}}{{/capture}}
                {{if isset($tabDefs[$label_upper].newTab) && $tabDefs[$label_upper].newTab == true}}
                    {{if $tabCount == '0'}}
                        <div class="tab-pane active fade in" id='tab-content-{{$tabCount}}'>
                            {{include file='themes/SuiteP/include/DetailView/tab_panel_content.tpl'}}
                        </div>
                    {{else}}
                        <div class="tab-pane fade" id='tab-content-{{$tabCount}}'>
                            {{include file='themes/SuiteP/include/DetailView/tab_panel_content.tpl'}}
                        </div>
                    {{/if}}
                {{/if}}
                {{counter name="tabCount" print=false}}
            {{/foreach}}
        {{else}}
            <div class="tab-pane panel-collapse">test</div>
        {{/if}}
    </div>
    {*display panels*}
    <div class="panel-content">
        <div>&nbsp;</div>
        {{counter name="panelCount" start=-1 print=false assign="panelCount"}}
        {{foreach name=section from=$sectionPanels key=label item=panel}}
        {{capture name=label_upper assign=label_upper}}{{$label|upper}}{{/capture}}
        {* if tab *}
        {{if (isset($tabDefs[$label_upper].newTab) && $tabDefs[$label_upper].newTab == true && $useTabs)}}
        {*if tab skip*}
        {{else}}
        {* if panel display*}
        {*if panel collasped*}
        {{if (isset($tabDefs[$label_upper].panelDefault) && $tabDefs[$label_upper].panelDefault == "collapsed") }}
        {*collapse panel*}
            {{assign var='collapse' value="panel-collapse collapse"}}
            {{assign var='collapsed' value="collapsed"}}
            {{assign var='collapseIcon' value="glyphicon glyphicon-plus"}}
            {{assign var='panelHeadingCollapse' value="panel-heading-collapse"}}
        {{else}}
        {*expand panel*}
            {{assign var='collapse' value="panel-collapse collapse in"}}
            {{assign var='collapseIcon' value="glyphicon glyphicon-minus"}}
            {{assign var='panelHeadingCollapse' value=""}}
        {{/if}}
        {{if $label != "LBL_AOP_CASE_UPDATES"}}
            {{assign var='panelId' value="top-panel-$panelCount"}}
        {{else}}
            {{assign var='panelId' value="LBL_AOP_CASE_UPDATES"}}
        {{/if}}
        <div class="panel panel-default">
            <div class="panel-heading {{$panelHeadingCollapse}}">
                <a class="{{$collapsed}}" role="button" data-toggle="collapse" href="#{{$panelId}}" aria-expanded="false">
                    <div class="col-xs-10 col-sm-11 col-md-11">
                         {sugar_translate label='{{$label}}' module='{{$module}}'}</div>
                    </div>
                </a>

            </div>
            <div class="panel-body {{$collapse}}" id="{{$panelId}}">
                <div class="tab-content">
                    {{include file='themes/SuiteP/include/DetailView/tab_panel_content.tpl'}}
                </div>
            </div>
        </div>

        {{/if}}
        {{counter name="panelCount" print=false}}
        {{/foreach}}
    </div>
</div>

{{include file=$footerTpl}}
{*{{if $useTabs}}*}
    {*<script type='text/javascript' src='{sugar_getjspath file='include/javascript/popup_helper.js'}'></script>*}
    {*<script type="text/javascript" src="{sugar_getjspath file='cache/include/javascript/sugar_grp_yui_widgets.js'}"></script>*}
    {*<script type="text/javascript">*}
        {*var {{$module}}_detailview_tabs = new YAHOO.widget.TabView("{{$module}}_detailview_tabs");*}
        {*{{$module}}_detailview_tabs.selectTab(0);*}
    {*</script>*}
{*{{/if}}*}
<script type="text/javascript" src="include/InlineEditing/inlineEditing.js"></script>
<script type="text/javascript" src="modules/Favorites/favorites.js"></script>

