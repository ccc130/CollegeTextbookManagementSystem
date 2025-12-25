<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="学期" prop="semester">
        <el-input
          v-model="queryParams.semester"
          placeholder="请输入学期"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="授课班级" prop="classId">
        <el-tree-select
          v-model="queryParams.classId"
          :data="classOptions"
          :props="{ value: 'deptId', label: 'deptName', children: 'children' }"
          value-key="deptId"
          placeholder="请选择授课班级"
          clearable
          filterable
        />
      </el-form-item>
      <el-form-item label="课程名称" prop="courseId">
        <el-select 
          v-model="queryParams.courseId" 
          placeholder="请选择课程" 
          clearable 
          filterable
        >
          <el-option
            v-for="item in courseOptions"
            :key="item.courseId"
            :label="item.courseName"
            :value="item.courseId"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="任课教师" prop="teacherId">
        <el-select 
          v-model="queryParams.teacherId" 
          placeholder="请选择任课教师" 
          clearable 
          filterable
        >
          <el-option
            v-for="item in teacherOptions"
            :key="item.userId"
            :label="item.userName"
            :value="item.userId"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="Plus"
          @click="handleAdd"
          v-hasPermi="['textbook:teachingplan:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['textbook:teachingplan:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['textbook:teachingplan:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['textbook:teachingplan:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="teachingplanList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="计划ID" align="center" prop="planId" />
      <el-table-column label="学期" align="center" prop="semester" />
      <el-table-column label="授课班级" align="center" prop="classId">
        <template #default="scope">
          {{ getClassNameById(scope.row.classId) }}
        </template>
      </el-table-column>
      <el-table-column label="课程名称" align="center" prop="courseId">
        <template #default="scope">
          {{ getCourseNameById(scope.row.courseId) }}
        </template>
      </el-table-column>
      <el-table-column label="任课教师" align="center" prop="teacherId">
        <template #default="scope">
          {{ getTeacherNameById(scope.row.teacherId) }}
        </template>
      </el-table-column>
      <el-table-column label="学生数量" align="center" prop="studentCount" />
      <el-table-column label="教材需求" align="center">
        <template #default="scope">
          <el-button link type="primary" @click="handleViewTextbooks(scope.row)" v-hasPermi="['textbook:teachingplan:viewTextbooks']">查看教材</el-button>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['textbook:teachingplan:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['textbook:teachingplan:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改教学计划对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="teachingplanRef" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="学期" prop="semester">
          <el-input v-model="form.semester" placeholder="请输入学期，如：2024-2025-1" />
        </el-form-item>
        <el-form-item label="授课班级" prop="classId">
          <el-tree-select
            v-model="form.classId"
            :data="classOptions"
            :props="{ value: 'deptId', label: 'deptName', children: 'children' }"
            value-key="deptId"
            placeholder="请选择授课班级"
            clearable
            filterable
          />
        </el-form-item>
        <el-form-item label="课程名称" prop="courseId">
          <el-select 
            v-model="form.courseId" 
            placeholder="请选择课程" 
            clearable 
            filterable
          >
            <el-option
              v-for="item in courseOptions"
              :key="item.courseId"
              :label="item.courseName"
              :value="item.courseId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="任课教师" prop="teacherId">
          <el-select 
            v-model="form.teacherId" 
            placeholder="请选择任课教师" 
            clearable 
            filterable
          >
            <el-option
              v-for="item in teacherOptions"
              :key="item.userId"
              :label="item.userName"
              :value="item.userId"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="学生数量" prop="studentCount">
          <el-input v-model="form.studentCount" placeholder="请输入学生数量" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
    
    <!-- 查看教材对话框 -->
    <el-dialog title="教材信息" v-model="textbookDialogVisible" width="700px" append-to-body>
      <el-table v-loading="textbookLoading" :data="textbookList">
        <el-table-column label="教材ID" align="center" prop="textbookId" />
        <el-table-column label="教材名称" align="center" prop="title" />
        <el-table-column label="ISBN" align="center" prop="isbn" />
        <el-table-column label="作者" align="center" prop="author" />
        <el-table-column label="出版社" align="center" prop="publisherId">
          <template #default="scope">
            {{ getPublisherNameById(scope.row.publisherId) }}
          </template>
        </el-table-column>
        <el-table-column label="所需数量" align="center" prop="requiredQuantity" />
      </el-table>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="textbookDialogVisible = false">关 闭</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="TeachingPlanList">
import { listTeachingplan, getTeachingplan, delTeachingplan, addTeachingplan, updateTeachingplan } from "@/api/textbook/teachingplan"
import { listCourse } from "@/api/textbook/course"
import { listUser } from "@/api/system/user"
import { listDept } from "@/api/system/dept"
import { listBooks } from "@/api/textbook/books"
import { listPublishers } from "@/api/system/publishers"

const { proxy } = getCurrentInstance()

const teachingplanList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
// 添加教材对话框相关变量
const textbookDialogVisible = ref(false)
const textbookLoading = ref(false)
const textbookList = ref([])
// 添加选项相关变量
const courseOptions = ref([])
const teacherOptions = ref([])
const classOptions = ref([])
const publisherOptions = ref([])

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    semester: null,
    classId: null,
    courseId: null,
    teacherId: null,
  },
  rules: {
    semester: [
      { required: true, message: "学期不能为空", trigger: "blur" }
    ],
    classId: [
      { required: true, message: "授课班级不能为空", trigger: "change" }
    ],
    courseId: [
      { required: true, message: "课程名称不能为空", trigger: "change" }
    ],
    teacherId: [
      { required: true, message: "任课教师不能为空", trigger: "change" }
    ],
    studentCount: [
      { required: true, message: "学生数量不能为空", trigger: "blur" },
      { pattern: /^[1-9]\d*$/, message: "学生数量必须为正整数", trigger: "blur" }
    ]
  }
})

const { queryParams, form, rules } = toRefs(data)

/** 查询教学计划列表 */
function getList() {
  loading.value = true
  listTeachingplan(queryParams.value).then(response => {
    teachingplanList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

/** 查询课程列表 */
function getCourseList() {
  listCourse({ pageSize: 1000 }).then(response => {
    courseOptions.value = response.rows.map(course => ({
      courseId: course.CourseID,
      courseName: course.CourseName
    }))
  })
}

/** 查询教师列表 */
function getTeacherList() {
  listUser({ pageSize: 1000 }).then(response => {
    teacherOptions.value = response.rows
  })
}

/** 查询班级列表 */
function getClassList() {
  listDept().then(response => {
    classOptions.value = proxy.handleTree(response.data, "deptId")
  })
}

/** 查询出版社列表 */
function getPublisherList() {
  listPublishers({ pageSize: 1000 }).then(response => {
    publisherOptions.value = response.rows
  })
}

// 根据ID获取班级名称
function getClassNameById(classId) {
  if (!classId) return '';
  
  // 递归查找部门名称
  function findDeptName(depts, id) {
    for (const dept of depts) {
      if (dept.deptId == id || dept.id == id) {
        return dept.deptName || dept.label;
      }
      if (dept.children) {
        const found = findDeptName(dept.children, id);
        if (found) return found;
      }
    }
    return id;
  }
  
  return findDeptName(classOptions.value, classId);
}

// 根据ID获取课程名称
function getCourseNameById(courseId) {
  if (!courseId) return '';
  
  const course = courseOptions.value.find(item => item.courseId == courseId);
  return course ? course.courseName : courseId;
}

// 根据ID获取教师名称
function getTeacherNameById(teacherId) {
  if (!teacherId) return '';
  
  const teacher = teacherOptions.value.find(item => item.userId == teacherId);
  return teacher ? teacher.userName : teacherId;
}

// 根据ID获取出版社名称
function getPublisherNameById(publisherId) {
  if (!publisherId) return '';
  
  const publisher = publisherOptions.value.find(item => item.publisherId == publisherId);
  return publisher ? publisher.publisherName : publisherId;
}

// 查看教材信息
async function handleViewTextbooks(row) {
  textbookDialogVisible.value = true
  textbookLoading.value = true
  
  try {
    // 这里应该根据教学计划获取相关的教材信息
    // 通过征订申请获取教材信息
    const { listRequests } = await import("@/api/system/requests")
    const response = await listRequests({ 
      courseId: row.courseId, 
      classId: row.classId,
      teacherId: row.teacherId,
      pageSize: 1000 
    })
    
    // 获取教材信息
    const textbookIds = [...new Set(response.rows.map(req => req.textbookId))]
    if (textbookIds.length > 0) {
      const textbookDetails = []
      for (const textbookId of textbookIds) {
        const { getBooks } = await import("@/api/textbook/books")
        try {
          const textbookResp = await getBooks(textbookId)
          const textbook = textbookResp.data
          
          // 计算该教材的总需求数量
          const requiredQuantity = response.rows
            .filter(req => req.textbookId === textbookId)
            .reduce((sum, req) => sum + parseInt(req.quantity || 0), 0)
          
          textbookDetails.push({
            ...textbook,
            requiredQuantity: requiredQuantity
          })
        } catch (error) {
          console.error(`获取教材信息失败: ${textbookId}`, error)
        }
      }
      
      textbookList.value = textbookDetails
    } else {
      textbookList.value = []
    }
  } catch (error) {
    console.error('获取教材信息失败', error)
    textbookList.value = []
  } finally {
    textbookLoading.value = false
  }
}

// 取消按钮
function cancel() {
  open.value = false
  reset()
}

// 表单重置
function reset() {
  form.value = {
    planId: null,
    semester: null,
    classId: null,
    courseId: null,
    teacherId: null,
    studentCount: null
  }
  proxy.resetForm("teachingplanRef")
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1
  getList()
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef")
  handleQuery()
}

// 多选框选中数据
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.planId)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

/** 新增按钮操作 */
function handleAdd() {
  reset()
  open.value = true
  title.value = "添加教学计划"
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset()
  const _planId = row.planId || ids.value
  getTeachingplan(_planId).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改教学计划"
  })
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["teachingplanRef"].validate(valid => {
    if (valid) {
      if (form.value.planId != null) {
        updateTeachingplan(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功")
          open.value = false
          getList()
        })
      } else {
        addTeachingplan(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功")
          open.value = false
          getList()
        })
      }
    }
  })
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _planIds = row.planId || ids.value
  proxy.$modal.confirm('是否确认删除教学计划编号为"' + _planIds + '"的数据项？').then(function() {
    return delTeachingplan(_planIds)
  }).then(() => {
    getList()
    proxy.$modal.msgSuccess("删除成功")
  }).catch(() => {})
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('textbook/teachingplan/export', {
    ...queryParams.value
  }, `teachingplan_${new Date().getTime()}.xlsx`)
}

onMounted(() => {
  getList()
  getCourseList()
  getTeacherList()
  getClassList()
  getPublisherList()
})
</script>