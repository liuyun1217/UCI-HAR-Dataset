###变量说明
X_test:测试数据
y_test:测试数据对应的动作名称代码
subject_test:测试数据对应的被试代码

X_train:培训数据
y_train:培训数据对应的动作名称代码
subject_train:培训数据对应的被试代码

features：测试数据对应的传感器项目
activity_lables：动作代码对应的名称    

name_test：测试数据被试代码与动作代码的整合
name_train：培训数据被试代码与动作代码的整合    

all_x：测试数据与培训数据的整合    

m_s_index：传感器数据中与平均值mean()以及标准差std()有关的名称
all_m_s_y:仅提取了平均值与标准差的数据集合   

all_m_s_y_name：带有描述性说明的数据集   


all_tidy_mean：使用每个表里的平均值建立的整洁数据集。   

###转换工作
主要进行了数据的整合，提取，融合，以及求平均。 
