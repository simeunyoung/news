<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구독</title>
</head>
<style>
.tab {
  display: flex;
  align-items: center;
  border-bottom: 1px solid #e6e8ea;
  margin-bottom: 30px; }
  .tab-menu {
    width: 100%;
    padding: 0 10px 6px 10px;
    font-size: 15px;
    color: rgba(20, 31, 64, 0.8);
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer; }
    .tab-menu.active {
      font-size: 15px;
      color: #00aace;
      border-bottom: 2px solid #1bc1db; }
  .tab-content {
    display: none; }
    .tab-content.active {
      display: block; }
</style>
<body>
 <ul class="tab">
            <li class="tab-menu active" data-tab="tab01">언론사 구독목록</li>
            <li class="tab-menu" data-tab="tab02">기자 구독목록</li>
            <li class="tab-menu" data-tab="tab03">스크랩목록</li>
</ul>
             <div class="tab-content active" id="tab01"><table>
  <thead>
    <tr>
    </tr>
  </thead>
  <tbody>
    <%
      // 반복문을 사용하여 데이터를 동적으로 출력
      for (int i = 0; i < 3; i++) {
    %>
    <tr>
      <td>데이터1</td>
      <td>
        <input type="checkbox" name="선택한_데이터[]" value="data" />
      </td>
    </tr>
    <%
      }
    %>
  </tbody>
</table>

             </div>
             <div class="tab-content active" id="tab02">2
             </div>
             <div class="tab-content active" id="tab03">3
             </div>

</body>
<script>
const li = document.querySelectorAll(".tab .tab-menu");

li.forEach(function (elem) {
  elem.addEventListener("click", function () {
    const tabId = this.getAttribute("data-tab");

    li.forEach(function (elem) {
      elem.classList.remove("active");
    });
    document.querySelectorAll(".tab-content").forEach(function (elem) {
      elem.classList.remove("active");
    });

    this.classList.add("active");
    document.querySelector("#" + tabId).classList.add("active");
  });
});


</script>
</html>