<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	/* String root = request.getRealPath("/"); → 예전 방식 */
	String root = pageContext.getServletContext().getRealPath("/");
	
	// 실제 물리적 주소 
	System.out.println(root);	// web에서 실행하고 console 창에서 확인 
	// /Users/hyeyeonii/SpringMVC/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/FileSystemApp03/
	// 워크스페이스/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/FileSystemApp03/
	
	// 저장되는 위치와 폴더
	String path = root + "pds" + File.separator + "saveData";
	
	// 확인
	// System.out.println(path);
	// /Users/hyeyeonii/SpringMVC/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/FileSystemApp03/pds/saveData
	
	// 저장 대상(디렉터리 경로)이 존재하지 않으면 생성 (pds/saveData)
	File dir = new File(path);
	if(!dir.exists())
		dir.mkdirs();
	
	String encType = "UTF-8";
	int maxFileSize = 5*1024*1024;	//전송 최대 사이즈 5M 
	
	/* try
	{
		MultipartRequest req = null;
		req = new MultipartRequest(request, path, maxFileSize, encType, new DefaultFileRenamePolicy());
		//                          요청객제  저장경로  파일최대크기   인코딩방식  파일 이름이 겹칠 때 파일 이름을 어떻게 지정하겠느냐(새로 만들기)          
		
		// out.println("이름 : " + request.getParameter("name") + "<br>");  --> null 나옴
		// Test1.jsp 에서 enctype="multipart/form-data" 방식을 사용했을 떼 req.getParameter 사용해야함
		out.println("제목 : " + req.getParameter("title") + "<br>");
		out.println("서버에 저장된 파일명 : " + req.getFilesystemName("upload") + "<br>");
		out.println("업로드한 파일명 : " + req.getOriginalFileName("upload") + "<br>");
		out.println("파일 타입 : " + req.getContentType("upload") + "<br>");
		
		File file = req.getFile("upload");
		if(file != null)
			out.println("파일 길이 : " + file.length() + "<br>");
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	} */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardInsertForm.jsp</title>

</head>
<body>
<jsp:include page="Main.jsp" />
<div>
 <form role="form" action="boardinsert.action" method="post" enctype="multipart/form-data">
      <table>
         <tr>
            <td>제목</td>
            <td>
               <input type="text" id="name" name="title">
            </td>
         </tr>
         <tr>
            <td>카테고리 선택</td>
            <td>
               <select id="selectcate" name="cate">
                  <option value="1" selected="selected">행사/할인정보</option>
                  <option value="2">리뷰</option>
                  <option value="3">수다</option>
                  <option value="4">중고장터</option>
               </select>
            </td>
         </tr>
         <tr>
            <td>첨부파일</td>
            <td>
              <input type="file" name="uploadFile">
            </td>
         </tr>
     </table>
     <br>
    <textarea style="width: 100%;" rows=20 placeholder="내용을 입력하세요" name="content"></textarea><br>

 
 <div style="width:100%; text-align: right;">
	  <button type="button" id="cancel" class="btn">취소</button>
	  <button type="submit" id="register" class="btn">글 등록</button>
 </div> 
 
 </form>
 </div>

</body>
</html>