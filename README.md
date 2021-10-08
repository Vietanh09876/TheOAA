# The OAA
Ứng dụng theo dõi, đánh giá học sinh

[Figma Design](https://www.figma.com/file/9QZqjCdTmCinKItsjsL3GY/OAA?node-id=0%3A1)

## Login Screen
<img src="https://raw.githubusercontent.com/Vietanh09876/TheOAA/main/Screenshots/LoginScreen.png" width=25% height=25%>

Sử dụng **tài khoản được đăng ký trước** để có dữ liệu từ Firestore:
* Email: nguyenvietanh09876@gmail.com (recommended)
* Mật khẩu: ngaodaman09
hoặc
* Email: ngaodaman09@gmail.com
* Mật khẩu: ngaodaman09 


Nếu cần đặt lại mật khẩu thì cần **điền email vào Textfield trước** rồi nhấn **Quên Mật Khẩu?**

## News Board Screen
<img src="https://raw.githubusercontent.com/Vietanh09876/TheOAA/main/Screenshots/NewsBoardScreen.png" width=25% height=25%>

Mục **Bảng Tin** sẽ hiển thị những thông báo mới nhất
* Nhấn vào một thông báo để hiển thị bản được phóng to của thông báo

Nhấn vào **Tên** ở khu vực thanh avatar để đến **Personal Info Screen** và xem các thông tin cá nhân của người dùng hiện tại

## Class List Screen
 <img src="https://raw.githubusercontent.com/Vietanh09876/TheOAA/main/Screenshots/ClassListScreen.png" width=25% height=25%>
 
Nhấn vào **Lớp Của Tôi** để xem các thông tin lớp học của người dùng hiện tại
Nhấn vào các mục **Khối 10, 11, 12** để xem danh sách các lớp có trong khối đó. Nhấn vào một lớp để xem thông tin của lớp đó.

### Class Info
 <img src="https://raw.githubusercontent.com/Vietanh09876/TheOAA/main/Screenshots/ClassMainInfo.png" width=25% height=25%>
 
Nhấn vào một học sinh để xem thông tin của học sinh đó.

 <img src="https://raw.githubusercontent.com/Vietanh09876/TheOAA/main/Screenshots/ClassStudentList.png" width=25% height=25%>
 
 <img src="https://raw.githubusercontent.com/Vietanh09876/TheOAA/main/Screenshots/ClassTeacherList.png" width=25% height=25%>

## Personal Info Screen
 <img src="https://raw.githubusercontent.com/Vietanh09876/TheOAA/main/Screenshots/EvaluationInfo.png" width=25% height=25%>
 
 * Học Lực: Được tính theo điểm số của các môn học
 * Thể Chất: Được tính theo đánh giá của bộ môn thể dục và việc tham gia các CLB thể thao hoặc sự kiện thể thao
 * Tư Duy: Được tính theo việc tham gia các hoạt động, sự kiện của trường
 * Đóng Góp Cộng Đồng: Được theo việc tham gia các hoạt động cộng đồng và CLB
 * Tổng quát được tính theo công thức:
 
 ![](/Screenshots/OverallScoreEquation.png)
 
  Bảng điểm của học sinh, có thể zoom in/out.
  
 <img src="https://raw.githubusercontent.com/Vietanh09876/TheOAA/main/Screenshots/ScoreboardScreen.png" width=25% height=25%>
 
 <img src="https://raw.githubusercontent.com/Vietanh09876/TheOAA/main/Screenshots/PersonalInfo.png" width=25% height=25%>
 
 <img src="https://raw.githubusercontent.com/Vietanh09876/TheOAA/main/Screenshots/CommunicationInfo.png" width=25% height=25%>
 
 <img src="https://raw.githubusercontent.com/Vietanh09876/TheOAA/main/Screenshots/AchievementInfo.png" width=25% height=25%>
 
 * Nhấn vào một **Thành Tựu** để danh sách các thành tựu được công nhận
 * Nhấn vào một **Thành Tựu (Khác)** để xem toàn bộ thông tin
 * Nhấn vào **dấu "+"** để yêu cầu phê duyệt một thành tựu (Khác)
 
 <img src="https://raw.githubusercontent.com/Vietanh09876/TheOAA/main/Screenshots/AddSubAchievement.png" width=25% height=25%>
 
 
## Chú Ý
 ![](/Screenshots/Error.png)
 Đã vượt quá limit Firebase Storage của ngày hôm nay nên không thể tải ảnh về.
