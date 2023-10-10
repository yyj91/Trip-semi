<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
#menu {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    padding: 10px;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 999;
    border-bottom:1px solid #ff6a24;
    background-color: transparent;
}

.menu-item {
    cursor: pointer;
    margin-left: 10px;
}

.menu-item:hover {
    cursor: pointer;
}
</style>
<div id="menu">
	<div class="menu-item" onclick="url('logout')">
		로그아웃
	</div>
</div>
<script type="text/javascript">
	function url(url) {
		location.href = "./" + url;
	}
</script>