﻿//------------------------------------------------------------------------------
// <auto-generated>
//    此代码是根据模板生成的。
//
//    手动更改此文件可能会导致应用程序中发生异常行为。
//    如果重新生成代码，则将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using System.Data.EntityClient;
using System.ComponentModel;
using System.Xml.Serialization;
using System.Runtime.Serialization;

[assembly: EdmSchemaAttribute()]

namespace LCourseConfigerWin
{
    #region 上下文
    
    /// <summary>
    /// 没有元数据文档可用。
    /// </summary>
    public partial class Database1Entities1 : ObjectContext
    {
        #region 构造函数
    
        /// <summary>
        /// 请使用应用程序配置文件的“Database1Entities1”部分中的连接字符串初始化新 Database1Entities1 对象。
        /// </summary>
        public Database1Entities1() : base("name=Database1Entities1", "Database1Entities1")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// 初始化新的 Database1Entities1 对象。
        /// </summary>
        public Database1Entities1(string connectionString) : base(connectionString, "Database1Entities1")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        /// <summary>
        /// 初始化新的 Database1Entities1 对象。
        /// </summary>
        public Database1Entities1(EntityConnection connection) : base(connection, "Database1Entities1")
        {
            this.ContextOptions.LazyLoadingEnabled = true;
            OnContextCreated();
        }
    
        #endregion
    
        #region 分部方法
    
        partial void OnContextCreated();
    
        #endregion
    
        #region ObjectSet 属性
    
        /// <summary>
        /// 没有元数据文档可用。
        /// </summary>
        public ObjectSet<config> config
        {
            get
            {
                if ((_config == null))
                {
                    _config = base.CreateObjectSet<config>("config");
                }
                return _config;
            }
        }
        private ObjectSet<config> _config;

        #endregion
        #region AddTo 方法
    
        /// <summary>
        /// 用于向 config EntitySet 添加新对象的方法，已弃用。请考虑改用关联的 ObjectSet&lt;T&gt; 属性的 .Add 方法。
        /// </summary>
        public void AddToconfig(config config)
        {
            base.AddObject("config", config);
        }

        #endregion
    }
    

    #endregion
    
    #region 实体
    
    /// <summary>
    /// 没有元数据文档可用。
    /// </summary>
    [EdmEntityTypeAttribute(NamespaceName="Database1Model", Name="config")]
    [Serializable()]
    [DataContractAttribute(IsReference=true)]
    public partial class config : EntityObject
    {
        #region 工厂方法
    
        /// <summary>
        /// 创建新的 config 对象。
        /// </summary>
        /// <param name="key">key 属性的初始值。</param>
        public static config Createconfig(global::System.String key)
        {
            config config = new config();
            config.key = key;
            return config;
        }

        #endregion
        #region 基元属性
    
        /// <summary>
        /// 没有元数据文档可用。
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [DataMemberAttribute()]
        public global::System.String key
        {
            get
            {
                return _key;
            }
            set
            {
                if (_key != value)
                {
                    OnkeyChanging(value);
                    ReportPropertyChanging("key");
                    _key = StructuralObject.SetValidValue(value, false);
                    ReportPropertyChanged("key");
                    OnkeyChanged();
                }
            }
        }
        private global::System.String _key;
        partial void OnkeyChanging(global::System.String value);
        partial void OnkeyChanged();
    
        /// <summary>
        /// 没有元数据文档可用。
        /// </summary>
        [EdmScalarPropertyAttribute(EntityKeyProperty=false, IsNullable=true)]
        [DataMemberAttribute()]
        public global::System.String value
        {
            get
            {
                return _value;
            }
            set
            {
                OnvalueChanging(value);
                ReportPropertyChanging("value");
                _value = StructuralObject.SetValidValue(value, true);
                ReportPropertyChanged("value");
                OnvalueChanged();
            }
        }
        private global::System.String _value;
        partial void OnvalueChanging(global::System.String value);
        partial void OnvalueChanged();

        #endregion
    
    }

    #endregion
    
}