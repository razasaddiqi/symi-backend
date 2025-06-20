PGDMP  *                     }         
   chatbot_db    17.4    17.4 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16439 
   chatbot_db    DATABASE     p   CREATE DATABASE chatbot_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en-US';
    DROP DATABASE chatbot_db;
                     postgres    false            �            1259    16588    audit_progress    TABLE     l   CREATE TABLE public.audit_progress (
    id integer NOT NULL,
    user_id integer,
    question_key text
);
 "   DROP TABLE public.audit_progress;
       public         heap r       postgres    false            �            1259    16587    audit_progress_id_seq    SEQUENCE     �   CREATE SEQUENCE public.audit_progress_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.audit_progress_id_seq;
       public               postgres    false    222            �           0    0    audit_progress_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.audit_progress_id_seq OWNED BY public.audit_progress.id;
          public               postgres    false    221            �            1259    42166    business_insights    TABLE     �   CREATE TABLE public.business_insights (
    id integer NOT NULL,
    user_id integer,
    insights text NOT NULL,
    generation_date timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 %   DROP TABLE public.business_insights;
       public         heap r       postgres    false            �            1259    42165    business_insights_id_seq    SEQUENCE     �   CREATE SEQUENCE public.business_insights_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.business_insights_id_seq;
       public               postgres    false    243            �           0    0    business_insights_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.business_insights_id_seq OWNED BY public.business_insights.id;
          public               postgres    false    242            �            1259    42130    business_profiles    TABLE     �  CREATE TABLE public.business_profiles (
    id integer NOT NULL,
    user_id integer,
    business_name character varying(255) NOT NULL,
    years_in_business integer NOT NULL,
    employee_count integer NOT NULL,
    revenue_range character varying(50) NOT NULL,
    growth_goals text,
    challenges jsonb,
    current_tools jsonb,
    industry_specifics jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 %   DROP TABLE public.business_profiles;
       public         heap r       postgres    false            �            1259    42129    business_profiles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.business_profiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.business_profiles_id_seq;
       public               postgres    false    239            �           0    0    business_profiles_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.business_profiles_id_seq OWNED BY public.business_profiles.id;
          public               postgres    false    238            �            1259    42148    business_twins    TABLE     �  CREATE TABLE public.business_twins (
    id integer NOT NULL,
    user_id integer,
    twin_name character varying(100) NOT NULL,
    status character varying(50) NOT NULL,
    creation_date timestamp without time zone NOT NULL,
    last_interaction timestamp without time zone,
    personality_traits jsonb,
    learning_data jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 "   DROP TABLE public.business_twins;
       public         heap r       postgres    false            �            1259    42147    business_twins_id_seq    SEQUENCE     �   CREATE SEQUENCE public.business_twins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.business_twins_id_seq;
       public               postgres    false    241            �           0    0    business_twins_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.business_twins_id_seq OWNED BY public.business_twins.id;
          public               postgres    false    240            �            1259    16578    chat_history    TABLE     �   CREATE TABLE public.chat_history (
    id integer NOT NULL,
    user_id integer,
    message text,
    response text,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
     DROP TABLE public.chat_history;
       public         heap r       postgres    false            �            1259    16577    chat_history_id_seq    SEQUENCE     �   CREATE SEQUENCE public.chat_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.chat_history_id_seq;
       public               postgres    false    220            �           0    0    chat_history_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.chat_history_id_seq OWNED BY public.chat_history.id;
          public               postgres    false    219            �            1259    16605    chatbot_settings    TABLE     W   CREATE TABLE public.chatbot_settings (
    id integer NOT NULL,
    model_name text
);
 $   DROP TABLE public.chatbot_settings;
       public         heap r       postgres    false            �            1259    24756    google_auth    TABLE     D  CREATE TABLE public.google_auth (
    id integer NOT NULL,
    user_id integer,
    google_id character varying(255) NOT NULL,
    name character varying(255),
    picture_url text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.google_auth;
       public         heap r       postgres    false            �            1259    24755    google_auth_id_seq    SEQUENCE     �   CREATE SEQUENCE public.google_auth_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.google_auth_id_seq;
       public               postgres    false    228            �           0    0    google_auth_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.google_auth_id_seq OWNED BY public.google_auth.id;
          public               postgres    false    227            �            1259    42215    implementation_blockers    TABLE     G  CREATE TABLE public.implementation_blockers (
    id integer NOT NULL,
    task_id integer,
    description text NOT NULL,
    identified_date timestamp without time zone NOT NULL,
    resolved_date timestamp without time zone,
    resolution_notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 +   DROP TABLE public.implementation_blockers;
       public         heap r       postgres    false            �            1259    42214    implementation_blockers_id_seq    SEQUENCE     �   CREATE SEQUENCE public.implementation_blockers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.implementation_blockers_id_seq;
       public               postgres    false    249            �           0    0    implementation_blockers_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.implementation_blockers_id_seq OWNED BY public.implementation_blockers.id;
          public               postgres    false    248            �            1259    42181    implementation_plans    TABLE     S  CREATE TABLE public.implementation_plans (
    id integer NOT NULL,
    user_id integer,
    plan_content text NOT NULL,
    creation_date timestamp without time zone NOT NULL,
    status character varying(50) NOT NULL,
    completion_percentage integer DEFAULT 0,
    last_updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 (   DROP TABLE public.implementation_plans;
       public         heap r       postgres    false            �            1259    42180    implementation_plans_id_seq    SEQUENCE     �   CREATE SEQUENCE public.implementation_plans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.implementation_plans_id_seq;
       public               postgres    false    245            �           0    0    implementation_plans_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.implementation_plans_id_seq OWNED BY public.implementation_plans.id;
          public               postgres    false    244            �            1259    42230    implementation_results    TABLE     H  CREATE TABLE public.implementation_results (
    id integer NOT NULL,
    plan_id integer,
    result_type character varying(50) NOT NULL,
    description text NOT NULL,
    measurement_values jsonb,
    date_achieved timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 *   DROP TABLE public.implementation_results;
       public         heap r       postgres    false            �            1259    42229    implementation_results_id_seq    SEQUENCE     �   CREATE SEQUENCE public.implementation_results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.implementation_results_id_seq;
       public               postgres    false    251            �           0    0    implementation_results_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.implementation_results_id_seq OWNED BY public.implementation_results.id;
          public               postgres    false    250            �            1259    42197    implementation_tasks    TABLE       CREATE TABLE public.implementation_tasks (
    id integer NOT NULL,
    plan_id integer,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    due_date date NOT NULL,
    priority character varying(20) NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    completion_percentage integer DEFAULT 0 NOT NULL,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 (   DROP TABLE public.implementation_tasks;
       public         heap r       postgres    false            �            1259    42196    implementation_tasks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.implementation_tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.implementation_tasks_id_seq;
       public               postgres    false    247            �           0    0    implementation_tasks_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.implementation_tasks_id_seq OWNED BY public.implementation_tasks.id;
          public               postgres    false    246            �            1259    41958    payment_status    TABLE     �  CREATE TABLE public.payment_status (
    id integer NOT NULL,
    user_id integer,
    status character varying(20) DEFAULT 'free'::character varying NOT NULL,
    payment_id character varying(100),
    payment_amount integer,
    payment_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    expiry_date timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    plan_id integer,
    CONSTRAINT payment_status_status_check CHECK (((status)::text = ANY ((ARRAY['free'::character varying, 'premium'::character varying])::text[])))
);
 "   DROP TABLE public.payment_status;
       public         heap r       postgres    false            �            1259    41957    payment_status_id_seq    SEQUENCE     �   CREATE SEQUENCE public.payment_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.payment_status_id_seq;
       public               postgres    false    230            �           0    0    payment_status_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.payment_status_id_seq OWNED BY public.payment_status.id;
          public               postgres    false    229                       1259    49332    pricing_plans    TABLE     ?  CREATE TABLE public.pricing_plans (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text NOT NULL,
    price numeric(10,2) NOT NULL,
    currency character varying(3) DEFAULT 'USD'::character varying NOT NULL,
    duration_days integer DEFAULT 365 NOT NULL,
    features jsonb DEFAULT '[]'::jsonb NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    display_order integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 !   DROP TABLE public.pricing_plans;
       public         heap r       postgres    false                       1259    49331    pricing_plans_id_seq    SEQUENCE     �   CREATE SEQUENCE public.pricing_plans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.pricing_plans_id_seq;
       public               postgres    false    259            �           0    0    pricing_plans_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.pricing_plans_id_seq OWNED BY public.pricing_plans.id;
          public               postgres    false    258            �            1259    42088    profession_prompts    TABLE       CREATE TABLE public.profession_prompts (
    id integer NOT NULL,
    profession_id integer NOT NULL,
    system_prompt text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 &   DROP TABLE public.profession_prompts;
       public         heap r       postgres    false            �            1259    42122    profession_prompts_backup    TABLE     �   CREATE TABLE public.profession_prompts_backup (
    id integer,
    profession_id integer,
    system_prompt text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);
 -   DROP TABLE public.profession_prompts_backup;
       public         heap r       postgres    false            �            1259    42087    profession_prompts_id_seq    SEQUENCE     �   CREATE SEQUENCE public.profession_prompts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.profession_prompts_id_seq;
       public               postgres    false    236            �           0    0    profession_prompts_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.profession_prompts_id_seq OWNED BY public.profession_prompts.id;
          public               postgres    false    235            �            1259    24695    professions    TABLE     �   CREATE TABLE public.professions (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.professions;
       public         heap r       postgres    false            �            1259    24694    professions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.professions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.professions_id_seq;
       public               postgres    false    226            �           0    0    professions_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.professions_id_seq OWNED BY public.professions.id;
          public               postgres    false    225            �            1259    41975    report_tracking    TABLE     �   CREATE TABLE public.report_tracking (
    id integer NOT NULL,
    user_id integer,
    report_type character varying(50) NOT NULL,
    report_name text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 #   DROP TABLE public.report_tracking;
       public         heap r       postgres    false            �            1259    41974    report_tracking_id_seq    SEQUENCE     �   CREATE SEQUENCE public.report_tracking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.report_tracking_id_seq;
       public               postgres    false    232            �           0    0    report_tracking_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.report_tracking_id_seq OWNED BY public.report_tracking.id;
          public               postgres    false    231            �            1259    16596    session_tracker    TABLE     �   CREATE TABLE public.session_tracker (
    user_id integer NOT NULL,
    last_active timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    session_expired boolean DEFAULT false
);
 #   DROP TABLE public.session_tracker;
       public         heap r       postgres    false            �            1259    42264    subscription_upgrades    TABLE     �  CREATE TABLE public.subscription_upgrades (
    id integer NOT NULL,
    user_id integer,
    session_id character varying(255) NOT NULL,
    current_tier character varying(50) NOT NULL,
    new_tier character varying(50) NOT NULL,
    status character varying(50) NOT NULL,
    subscription_id character varying(255),
    created_at timestamp without time zone NOT NULL,
    completed_at timestamp without time zone
);
 )   DROP TABLE public.subscription_upgrades;
       public         heap r       postgres    false            �            1259    42263    subscription_upgrades_id_seq    SEQUENCE     �   CREATE SEQUENCE public.subscription_upgrades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.subscription_upgrades_id_seq;
       public               postgres    false    255            �           0    0    subscription_upgrades_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.subscription_upgrades_id_seq OWNED BY public.subscription_upgrades.id;
          public               postgres    false    254            �            1259    42245    subscriptions    TABLE       CREATE TABLE public.subscriptions (
    id integer NOT NULL,
    user_id integer,
    tier character varying(50) NOT NULL,
    status character varying(50) NOT NULL,
    started_on timestamp without time zone NOT NULL,
    expires_on timestamp without time zone NOT NULL,
    features_enabled jsonb NOT NULL,
    payment_method character varying(50),
    auto_renew boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 !   DROP TABLE public.subscriptions;
       public         heap r       postgres    false            �            1259    42244    subscriptions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.subscriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.subscriptions_id_seq;
       public               postgres    false    253            �           0    0    subscriptions_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.subscriptions_id_seq OWNED BY public.subscriptions.id;
          public               postgres    false    252                       1259    42280    user_activity    TABLE     �   CREATE TABLE public.user_activity (
    id integer NOT NULL,
    user_id integer,
    activity_type character varying(50) NOT NULL,
    activity_data jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 !   DROP TABLE public.user_activity;
       public         heap r       postgres    false                        1259    42279    user_activity_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.user_activity_id_seq;
       public               postgres    false    257            �           0    0    user_activity_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.user_activity_id_seq OWNED BY public.user_activity.id;
          public               postgres    false    256            �            1259    42078    user_profession    TABLE     �   CREATE TABLE public.user_profession (
    id integer NOT NULL,
    user_id integer NOT NULL,
    profession_id integer NOT NULL,
    selected_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 #   DROP TABLE public.user_profession;
       public         heap r       postgres    false            �            1259    42077    user_profession_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_profession_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.user_profession_id_seq;
       public               postgres    false    234            �           0    0    user_profession_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.user_profession_id_seq OWNED BY public.user_profession.id;
          public               postgres    false    233            �            1259    16562    users    TABLE       CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password_hash text NOT NULL,
    role character varying(20) DEFAULT 'business_owner'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(20) DEFAULT true,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['admin'::character varying, 'business_owner'::character varying])::text[])))
);
    DROP TABLE public.users;
       public         heap r       postgres    false            �            1259    16561    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public               postgres    false    218            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public               postgres    false    217            �           2604    16591    audit_progress id    DEFAULT     v   ALTER TABLE ONLY public.audit_progress ALTER COLUMN id SET DEFAULT nextval('public.audit_progress_id_seq'::regclass);
 @   ALTER TABLE public.audit_progress ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    221    222    222            �           2604    42169    business_insights id    DEFAULT     |   ALTER TABLE ONLY public.business_insights ALTER COLUMN id SET DEFAULT nextval('public.business_insights_id_seq'::regclass);
 C   ALTER TABLE public.business_insights ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    243    242    243            �           2604    42133    business_profiles id    DEFAULT     |   ALTER TABLE ONLY public.business_profiles ALTER COLUMN id SET DEFAULT nextval('public.business_profiles_id_seq'::regclass);
 C   ALTER TABLE public.business_profiles ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    238    239    239            �           2604    42151    business_twins id    DEFAULT     v   ALTER TABLE ONLY public.business_twins ALTER COLUMN id SET DEFAULT nextval('public.business_twins_id_seq'::regclass);
 @   ALTER TABLE public.business_twins ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    240    241    241            �           2604    16581    chat_history id    DEFAULT     r   ALTER TABLE ONLY public.chat_history ALTER COLUMN id SET DEFAULT nextval('public.chat_history_id_seq'::regclass);
 >   ALTER TABLE public.chat_history ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    220    219    220            �           2604    24759    google_auth id    DEFAULT     p   ALTER TABLE ONLY public.google_auth ALTER COLUMN id SET DEFAULT nextval('public.google_auth_id_seq'::regclass);
 =   ALTER TABLE public.google_auth ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    227    228    228            �           2604    42218    implementation_blockers id    DEFAULT     �   ALTER TABLE ONLY public.implementation_blockers ALTER COLUMN id SET DEFAULT nextval('public.implementation_blockers_id_seq'::regclass);
 I   ALTER TABLE public.implementation_blockers ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    249    248    249            �           2604    42184    implementation_plans id    DEFAULT     �   ALTER TABLE ONLY public.implementation_plans ALTER COLUMN id SET DEFAULT nextval('public.implementation_plans_id_seq'::regclass);
 F   ALTER TABLE public.implementation_plans ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    245    244    245            �           2604    42233    implementation_results id    DEFAULT     �   ALTER TABLE ONLY public.implementation_results ALTER COLUMN id SET DEFAULT nextval('public.implementation_results_id_seq'::regclass);
 H   ALTER TABLE public.implementation_results ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    251    250    251            �           2604    42200    implementation_tasks id    DEFAULT     �   ALTER TABLE ONLY public.implementation_tasks ALTER COLUMN id SET DEFAULT nextval('public.implementation_tasks_id_seq'::regclass);
 F   ALTER TABLE public.implementation_tasks ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    246    247    247            �           2604    41961    payment_status id    DEFAULT     v   ALTER TABLE ONLY public.payment_status ALTER COLUMN id SET DEFAULT nextval('public.payment_status_id_seq'::regclass);
 @   ALTER TABLE public.payment_status ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    230    229    230            �           2604    49335    pricing_plans id    DEFAULT     t   ALTER TABLE ONLY public.pricing_plans ALTER COLUMN id SET DEFAULT nextval('public.pricing_plans_id_seq'::regclass);
 ?   ALTER TABLE public.pricing_plans ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    258    259    259            �           2604    42091    profession_prompts id    DEFAULT     ~   ALTER TABLE ONLY public.profession_prompts ALTER COLUMN id SET DEFAULT nextval('public.profession_prompts_id_seq'::regclass);
 D   ALTER TABLE public.profession_prompts ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    235    236    236            �           2604    24698    professions id    DEFAULT     p   ALTER TABLE ONLY public.professions ALTER COLUMN id SET DEFAULT nextval('public.professions_id_seq'::regclass);
 =   ALTER TABLE public.professions ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    225    226    226            �           2604    41978    report_tracking id    DEFAULT     x   ALTER TABLE ONLY public.report_tracking ALTER COLUMN id SET DEFAULT nextval('public.report_tracking_id_seq'::regclass);
 A   ALTER TABLE public.report_tracking ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    232    231    232            �           2604    42267    subscription_upgrades id    DEFAULT     �   ALTER TABLE ONLY public.subscription_upgrades ALTER COLUMN id SET DEFAULT nextval('public.subscription_upgrades_id_seq'::regclass);
 G   ALTER TABLE public.subscription_upgrades ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    255    254    255            �           2604    42248    subscriptions id    DEFAULT     t   ALTER TABLE ONLY public.subscriptions ALTER COLUMN id SET DEFAULT nextval('public.subscriptions_id_seq'::regclass);
 ?   ALTER TABLE public.subscriptions ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    252    253    253            �           2604    42283    user_activity id    DEFAULT     t   ALTER TABLE ONLY public.user_activity ALTER COLUMN id SET DEFAULT nextval('public.user_activity_id_seq'::regclass);
 ?   ALTER TABLE public.user_activity ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    257    256    257            �           2604    42081    user_profession id    DEFAULT     x   ALTER TABLE ONLY public.user_profession ALTER COLUMN id SET DEFAULT nextval('public.user_profession_id_seq'::regclass);
 A   ALTER TABLE public.user_profession ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    233    234    234            �           2604    16565    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    217    218    218            �          0    16588    audit_progress 
   TABLE DATA           C   COPY public.audit_progress (id, user_id, question_key) FROM stdin;
    public               postgres    false    222   �       �          0    42166    business_insights 
   TABLE DATA           _   COPY public.business_insights (id, user_id, insights, generation_date, created_at) FROM stdin;
    public               postgres    false    243   8�       �          0    42130    business_profiles 
   TABLE DATA           �   COPY public.business_profiles (id, user_id, business_name, years_in_business, employee_count, revenue_range, growth_goals, challenges, current_tools, industry_specifics, created_at, updated_at) FROM stdin;
    public               postgres    false    239   S�       �          0    42148    business_twins 
   TABLE DATA           �   COPY public.business_twins (id, user_id, twin_name, status, creation_date, last_interaction, personality_traits, learning_data, created_at, updated_at) FROM stdin;
    public               postgres    false    241   ��       �          0    16578    chat_history 
   TABLE DATA           S   COPY public.chat_history (id, user_id, message, response, "timestamp") FROM stdin;
    public               postgres    false    220   �       �          0    16605    chatbot_settings 
   TABLE DATA           :   COPY public.chatbot_settings (id, model_name) FROM stdin;
    public               postgres    false    224   �.      �          0    24756    google_auth 
   TABLE DATA           h   COPY public.google_auth (id, user_id, google_id, name, picture_url, created_at, updated_at) FROM stdin;
    public               postgres    false    228   �.      �          0    42215    implementation_blockers 
   TABLE DATA           �   COPY public.implementation_blockers (id, task_id, description, identified_date, resolved_date, resolution_notes, created_at) FROM stdin;
    public               postgres    false    249   �.      �          0    42181    implementation_plans 
   TABLE DATA           �   COPY public.implementation_plans (id, user_id, plan_content, creation_date, status, completion_percentage, last_updated) FROM stdin;
    public               postgres    false    245   �.      �          0    42230    implementation_results 
   TABLE DATA           �   COPY public.implementation_results (id, plan_id, result_type, description, measurement_values, date_achieved, created_at) FROM stdin;
    public               postgres    false    251   /      �          0    42197    implementation_tasks 
   TABLE DATA           �   COPY public.implementation_tasks (id, plan_id, title, description, due_date, priority, status, completion_percentage, notes, created_at, updated_at) FROM stdin;
    public               postgres    false    247   9/      �          0    41958    payment_status 
   TABLE DATA           �   COPY public.payment_status (id, user_id, status, payment_id, payment_amount, payment_date, expiry_date, created_at, updated_at, plan_id) FROM stdin;
    public               postgres    false    230   V/      �          0    49332    pricing_plans 
   TABLE DATA           �   COPY public.pricing_plans (id, name, description, price, currency, duration_days, features, is_active, display_order, created_at, updated_at) FROM stdin;
    public               postgres    false    259   j0      �          0    42088    profession_prompts 
   TABLE DATA           f   COPY public.profession_prompts (id, profession_id, system_prompt, created_at, updated_at) FROM stdin;
    public               postgres    false    236   �2      �          0    42122    profession_prompts_backup 
   TABLE DATA           m   COPY public.profession_prompts_backup (id, profession_id, system_prompt, created_at, updated_at) FROM stdin;
    public               postgres    false    237   T      �          0    24695    professions 
   TABLE DATA           H   COPY public.professions (id, name, description, created_at) FROM stdin;
    public               postgres    false    226   �]      �          0    41975    report_tracking 
   TABLE DATA           \   COPY public.report_tracking (id, user_id, report_type, report_name, created_at) FROM stdin;
    public               postgres    false    232   �_      �          0    16596    session_tracker 
   TABLE DATA           P   COPY public.session_tracker (user_id, last_active, session_expired) FROM stdin;
    public               postgres    false    223   #`      �          0    42264    subscription_upgrades 
   TABLE DATA           �   COPY public.subscription_upgrades (id, user_id, session_id, current_tier, new_tier, status, subscription_id, created_at, completed_at) FROM stdin;
    public               postgres    false    255   �`      �          0    42245    subscriptions 
   TABLE DATA           �   COPY public.subscriptions (id, user_id, tier, status, started_on, expires_on, features_enabled, payment_method, auto_renew, created_at, updated_at) FROM stdin;
    public               postgres    false    253   �`      �          0    42280    user_activity 
   TABLE DATA           ^   COPY public.user_activity (id, user_id, activity_type, activity_data, created_at) FROM stdin;
    public               postgres    false    257   a      �          0    42078    user_profession 
   TABLE DATA           R   COPY public.user_profession (id, user_id, profession_id, selected_at) FROM stdin;
    public               postgres    false    234   2a      �          0    16562    users 
   TABLE DATA           ]   COPY public.users (id, username, email, password_hash, role, created_at, status) FROM stdin;
    public               postgres    false    218   qa      �           0    0    audit_progress_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.audit_progress_id_seq', 1, false);
          public               postgres    false    221            �           0    0    business_insights_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.business_insights_id_seq', 1, true);
          public               postgres    false    242            �           0    0    business_profiles_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.business_profiles_id_seq', 1, true);
          public               postgres    false    238            �           0    0    business_twins_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.business_twins_id_seq', 1, true);
          public               postgres    false    240            �           0    0    chat_history_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.chat_history_id_seq', 205, true);
          public               postgres    false    219            �           0    0    google_auth_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.google_auth_id_seq', 1, false);
          public               postgres    false    227            �           0    0    implementation_blockers_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.implementation_blockers_id_seq', 1, false);
          public               postgres    false    248            �           0    0    implementation_plans_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.implementation_plans_id_seq', 1, false);
          public               postgres    false    244            �           0    0    implementation_results_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.implementation_results_id_seq', 1, false);
          public               postgres    false    250            �           0    0    implementation_tasks_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.implementation_tasks_id_seq', 1, false);
          public               postgres    false    246            �           0    0    payment_status_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.payment_status_id_seq', 7, true);
          public               postgres    false    229                        0    0    pricing_plans_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.pricing_plans_id_seq', 7, true);
          public               postgres    false    258                       0    0    profession_prompts_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.profession_prompts_id_seq', 18, true);
          public               postgres    false    235                       0    0    professions_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.professions_id_seq', 28, true);
          public               postgres    false    225                       0    0    report_tracking_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.report_tracking_id_seq', 3, true);
          public               postgres    false    231                       0    0    subscription_upgrades_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.subscription_upgrades_id_seq', 1, false);
          public               postgres    false    254                       0    0    subscriptions_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.subscriptions_id_seq', 1, false);
          public               postgres    false    252                       0    0    user_activity_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.user_activity_id_seq', 1, false);
          public               postgres    false    256                       0    0    user_profession_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.user_profession_id_seq', 4, true);
          public               postgres    false    233                       0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 16, true);
          public               postgres    false    217            �           2606    16595 "   audit_progress audit_progress_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.audit_progress
    ADD CONSTRAINT audit_progress_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.audit_progress DROP CONSTRAINT audit_progress_pkey;
       public                 postgres    false    222            �           2606    42174 (   business_insights business_insights_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.business_insights
    ADD CONSTRAINT business_insights_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.business_insights DROP CONSTRAINT business_insights_pkey;
       public                 postgres    false    243            �           2606    42139 (   business_profiles business_profiles_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.business_profiles
    ADD CONSTRAINT business_profiles_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.business_profiles DROP CONSTRAINT business_profiles_pkey;
       public                 postgres    false    239            �           2606    42141 /   business_profiles business_profiles_user_id_key 
   CONSTRAINT     m   ALTER TABLE ONLY public.business_profiles
    ADD CONSTRAINT business_profiles_user_id_key UNIQUE (user_id);
 Y   ALTER TABLE ONLY public.business_profiles DROP CONSTRAINT business_profiles_user_id_key;
       public                 postgres    false    239            �           2606    42157 "   business_twins business_twins_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.business_twins
    ADD CONSTRAINT business_twins_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.business_twins DROP CONSTRAINT business_twins_pkey;
       public                 postgres    false    241            �           2606    42159 )   business_twins business_twins_user_id_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.business_twins
    ADD CONSTRAINT business_twins_user_id_key UNIQUE (user_id);
 S   ALTER TABLE ONLY public.business_twins DROP CONSTRAINT business_twins_user_id_key;
       public                 postgres    false    241            �           2606    16586    chat_history chat_history_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.chat_history
    ADD CONSTRAINT chat_history_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.chat_history DROP CONSTRAINT chat_history_pkey;
       public                 postgres    false    220            �           2606    16611 &   chatbot_settings chatbot_settings_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.chatbot_settings
    ADD CONSTRAINT chatbot_settings_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.chatbot_settings DROP CONSTRAINT chatbot_settings_pkey;
       public                 postgres    false    224            �           2606    24769 %   google_auth google_auth_google_id_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.google_auth
    ADD CONSTRAINT google_auth_google_id_key UNIQUE (google_id);
 O   ALTER TABLE ONLY public.google_auth DROP CONSTRAINT google_auth_google_id_key;
       public                 postgres    false    228            �           2606    24765    google_auth google_auth_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.google_auth
    ADD CONSTRAINT google_auth_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.google_auth DROP CONSTRAINT google_auth_pkey;
       public                 postgres    false    228            �           2606    24767 #   google_auth google_auth_user_id_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.google_auth
    ADD CONSTRAINT google_auth_user_id_key UNIQUE (user_id);
 M   ALTER TABLE ONLY public.google_auth DROP CONSTRAINT google_auth_user_id_key;
       public                 postgres    false    228                        2606    42223 4   implementation_blockers implementation_blockers_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY public.implementation_blockers
    ADD CONSTRAINT implementation_blockers_pkey PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.implementation_blockers DROP CONSTRAINT implementation_blockers_pkey;
       public                 postgres    false    249            �           2606    42190 .   implementation_plans implementation_plans_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.implementation_plans
    ADD CONSTRAINT implementation_plans_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.implementation_plans DROP CONSTRAINT implementation_plans_pkey;
       public                 postgres    false    245                       2606    42238 2   implementation_results implementation_results_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.implementation_results
    ADD CONSTRAINT implementation_results_pkey PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.implementation_results DROP CONSTRAINT implementation_results_pkey;
       public                 postgres    false    251            �           2606    42208 .   implementation_tasks implementation_tasks_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.implementation_tasks
    ADD CONSTRAINT implementation_tasks_pkey PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.implementation_tasks DROP CONSTRAINT implementation_tasks_pkey;
       public                 postgres    false    247            �           2606    41968 "   payment_status payment_status_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.payment_status
    ADD CONSTRAINT payment_status_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.payment_status DROP CONSTRAINT payment_status_pkey;
       public                 postgres    false    230                       2606    49346     pricing_plans pricing_plans_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.pricing_plans
    ADD CONSTRAINT pricing_plans_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.pricing_plans DROP CONSTRAINT pricing_plans_pkey;
       public                 postgres    false    259            �           2606    42097 *   profession_prompts profession_prompts_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.profession_prompts
    ADD CONSTRAINT profession_prompts_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.profession_prompts DROP CONSTRAINT profession_prompts_pkey;
       public                 postgres    false    236            �           2606    42099 7   profession_prompts profession_prompts_profession_id_key 
   CONSTRAINT     {   ALTER TABLE ONLY public.profession_prompts
    ADD CONSTRAINT profession_prompts_profession_id_key UNIQUE (profession_id);
 a   ALTER TABLE ONLY public.profession_prompts DROP CONSTRAINT profession_prompts_profession_id_key;
       public                 postgres    false    236            �           2606    24705     professions professions_name_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.professions
    ADD CONSTRAINT professions_name_key UNIQUE (name);
 J   ALTER TABLE ONLY public.professions DROP CONSTRAINT professions_name_key;
       public                 postgres    false    226            �           2606    24703    professions professions_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.professions
    ADD CONSTRAINT professions_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.professions DROP CONSTRAINT professions_pkey;
       public                 postgres    false    226            �           2606    41983 $   report_tracking report_tracking_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.report_tracking
    ADD CONSTRAINT report_tracking_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.report_tracking DROP CONSTRAINT report_tracking_pkey;
       public                 postgres    false    232            �           2606    16627 $   session_tracker session_tracker_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.session_tracker
    ADD CONSTRAINT session_tracker_pkey PRIMARY KEY (user_id);
 N   ALTER TABLE ONLY public.session_tracker DROP CONSTRAINT session_tracker_pkey;
       public                 postgres    false    223                       2606    42271 0   subscription_upgrades subscription_upgrades_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.subscription_upgrades
    ADD CONSTRAINT subscription_upgrades_pkey PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.subscription_upgrades DROP CONSTRAINT subscription_upgrades_pkey;
       public                 postgres    false    255            
           2606    42273 :   subscription_upgrades subscription_upgrades_session_id_key 
   CONSTRAINT     {   ALTER TABLE ONLY public.subscription_upgrades
    ADD CONSTRAINT subscription_upgrades_session_id_key UNIQUE (session_id);
 d   ALTER TABLE ONLY public.subscription_upgrades DROP CONSTRAINT subscription_upgrades_session_id_key;
       public                 postgres    false    255                       2606    42255     subscriptions subscriptions_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.subscriptions DROP CONSTRAINT subscriptions_pkey;
       public                 postgres    false    253                       2606    42257 '   subscriptions subscriptions_user_id_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_user_id_key UNIQUE (user_id);
 Q   ALTER TABLE ONLY public.subscriptions DROP CONSTRAINT subscriptions_user_id_key;
       public                 postgres    false    253                       2606    42288     user_activity user_activity_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.user_activity
    ADD CONSTRAINT user_activity_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.user_activity DROP CONSTRAINT user_activity_pkey;
       public                 postgres    false    257            �           2606    42084 $   user_profession user_profession_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.user_profession
    ADD CONSTRAINT user_profession_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.user_profession DROP CONSTRAINT user_profession_pkey;
       public                 postgres    false    234            �           2606    42086 +   user_profession user_profession_user_id_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.user_profession
    ADD CONSTRAINT user_profession_user_id_key UNIQUE (user_id);
 U   ALTER TABLE ONLY public.user_profession DROP CONSTRAINT user_profession_user_id_key;
       public                 postgres    false    234            �           2606    16576    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public                 postgres    false    218            �           2606    16572    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 postgres    false    218            �           2606    16574    users users_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
       public                 postgres    false    218            �           1259    24776    idx_google_auth_google_id    INDEX     V   CREATE INDEX idx_google_auth_google_id ON public.google_auth USING btree (google_id);
 -   DROP INDEX public.idx_google_auth_google_id;
       public                 postgres    false    228            �           1259    24775    idx_google_auth_user_id    INDEX     R   CREATE INDEX idx_google_auth_user_id ON public.google_auth USING btree (user_id);
 +   DROP INDEX public.idx_google_auth_user_id;
       public                 postgres    false    228                       2606    42175 0   business_insights business_insights_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.business_insights
    ADD CONSTRAINT business_insights_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.business_insights DROP CONSTRAINT business_insights_user_id_fkey;
       public               postgres    false    243    218    4814                       2606    42142 0   business_profiles business_profiles_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.business_profiles
    ADD CONSTRAINT business_profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.business_profiles DROP CONSTRAINT business_profiles_user_id_fkey;
       public               postgres    false    239    4814    218                       2606    42160 *   business_twins business_twins_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.business_twins
    ADD CONSTRAINT business_twins_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.business_twins DROP CONSTRAINT business_twins_user_id_fkey;
       public               postgres    false    4814    218    241                       2606    24770 $   google_auth google_auth_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.google_auth
    ADD CONSTRAINT google_auth_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.google_auth DROP CONSTRAINT google_auth_user_id_fkey;
       public               postgres    false    4814    228    218                       2606    42224 <   implementation_blockers implementation_blockers_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.implementation_blockers
    ADD CONSTRAINT implementation_blockers_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.implementation_tasks(id) ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.implementation_blockers DROP CONSTRAINT implementation_blockers_task_id_fkey;
       public               postgres    false    249    4862    247                       2606    42191 6   implementation_plans implementation_plans_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.implementation_plans
    ADD CONSTRAINT implementation_plans_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.implementation_plans DROP CONSTRAINT implementation_plans_user_id_fkey;
       public               postgres    false    218    4814    245                       2606    42239 :   implementation_results implementation_results_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.implementation_results
    ADD CONSTRAINT implementation_results_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.implementation_plans(id) ON DELETE CASCADE;
 d   ALTER TABLE ONLY public.implementation_results DROP CONSTRAINT implementation_results_plan_id_fkey;
       public               postgres    false    245    251    4860                       2606    42209 6   implementation_tasks implementation_tasks_plan_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.implementation_tasks
    ADD CONSTRAINT implementation_tasks_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.implementation_plans(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.implementation_tasks DROP CONSTRAINT implementation_tasks_plan_id_fkey;
       public               postgres    false    247    245    4860                       2606    41969 *   payment_status payment_status_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.payment_status
    ADD CONSTRAINT payment_status_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.payment_status DROP CONSTRAINT payment_status_user_id_fkey;
       public               postgres    false    4814    230    218                       2606    42115 8   profession_prompts profession_prompts_profession_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.profession_prompts
    ADD CONSTRAINT profession_prompts_profession_id_fkey FOREIGN KEY (profession_id) REFERENCES public.professions(id) ON DELETE CASCADE;
 b   ALTER TABLE ONLY public.profession_prompts DROP CONSTRAINT profession_prompts_profession_id_fkey;
       public               postgres    false    226    4828    236                       2606    41984 ,   report_tracking report_tracking_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.report_tracking
    ADD CONSTRAINT report_tracking_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.report_tracking DROP CONSTRAINT report_tracking_user_id_fkey;
       public               postgres    false    4814    218    232                       2606    42274 8   subscription_upgrades subscription_upgrades_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.subscription_upgrades
    ADD CONSTRAINT subscription_upgrades_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 b   ALTER TABLE ONLY public.subscription_upgrades DROP CONSTRAINT subscription_upgrades_user_id_fkey;
       public               postgres    false    255    218    4814                       2606    42258 (   subscriptions subscriptions_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.subscriptions DROP CONSTRAINT subscriptions_user_id_fkey;
       public               postgres    false    218    4814    253                       2606    42289 (   user_activity user_activity_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_activity
    ADD CONSTRAINT user_activity_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.user_activity DROP CONSTRAINT user_activity_user_id_fkey;
       public               postgres    false    4814    218    257                       2606    42105 2   user_profession user_profession_profession_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_profession
    ADD CONSTRAINT user_profession_profession_id_fkey FOREIGN KEY (profession_id) REFERENCES public.professions(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.user_profession DROP CONSTRAINT user_profession_profession_id_fkey;
       public               postgres    false    234    226    4828                       2606    42110 ,   user_profession user_profession_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_profession
    ADD CONSTRAINT user_profession_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.user_profession DROP CONSTRAINT user_profession_user_id_fkey;
       public               postgres    false    218    4814    234            �      x������ � �      �     x��Z�n�8}N��0���&�f/y�:�1o;�}�l�R3�DI��;ȿ�"E�e�7c��&�u9u�y���~?�����k������^+w�J����׾Q���͗^v��hM9^|�*euW���8*�+��6=�<�R�0mߨVu^ڝ��]'�N٭.���VI��U[�J8��NЃ�{+�kkd��(�M�ָ���m�#��G��͞��t~����N�<;~�쉸�~�;�7JT�:/vJ�Qf�<���љ���V��!��p��Jz���I�h�P_��徆��ax�w���UKՈ
�!�:u+L�4����ӟ�/�5�T��0�:���x/�������ZyUFC�($\����ѯ�u�*+[ƅ*��
�lK��3XD��S�T%��0ӸU�P\BΆٮ���C	]���D��n#;���kt��Iƿ���⑭���GP&������3�-�n��^�F�c0!Nu��3ܝ���tZ�D����[�Fɒ���R<�D���p{��CX<J���{ͣ�>k��w[^�z��8Sn[�Sf��"L+���O�ir7�9�߼
�a�@}��R-0�����(�o^�p�I��f�ߥ0��"Z�U��H��Px�s���wdG���Wd�v�m��BC7C�Utm!>J�;��F�K<���4��w!�����\ _�P[�J���ğ�`W�M�
���'g<-��#jH t�&�)n#)&�=��� ����|���!0�/�_tM�z���6B*���̔d,&�v��U�*�(L�ȵ����+[,�_�6A(!"�a5(볰�����/�^|��A'���B����_ �Fհ�l��LQ!k�؃�#=��J���kH.�q�j_q%e�DUVy&�L��YE��"g�X!�q�Ҋ��}#=�����l��%p7-b����g� 0OV��X!�L�
����L.��ߢ88��˃0}���@�is�*��}���F�Fh]����2G�*Vm��o�w��OV�s����ʦK���W-�^7���P��/G���Ԕ���XSF	<qC2�7�q��>`�<�;� �BQ�[�J���c-8`Λ�����2� N��|G� ��x�C� 
C��e]�f��茠��{3�]2HKHP�8[��1��#�С!�p+y�r�����̐��)���[�!�7c�H�9�
B.ZȺ	5<�&�)����������:�0�&���	��Y��M���cO�G��u`�e��'�F��K0H`L D�jHEu+������]��@�cT\�ڒ_B�2��5�F䇳��b�t�W]��v�o��t�;KrQI�d�F�[�)B,��t���ѕ"O	�����7�L�zLA��=I��5�<6�qkTe�P�����OR/�Ж��a��f��@�h�	��ɭ�q):��3��z*����:��P��b����ŏ1���)x�Qւ]���]+��fp��6kD���KAҡOA-q�{C�}zy�a5k���5�w59�q��lo��U��3�&��fS�?�������`�x����&�,ԛ!{m$��X>�i*�sX��w4\D�u!'���V�������+u��1���!�����|ߓ�xI1+Sɑ�Ǽ���n|���8*;>�=י�D����
]c�V8_c[ѿ���<ӹq`���݀���
���0K���m�7y N~����9�"���S�x%.�ۂ�?q]㍅³жV?��y��wt�+�����G���ꍧp����GO�j� h,+���0���ɑH"�� �7�{�q�/exd6�}?x2(5�{K����g�o�i�8i�$���ca&{���~��wB4�f���@�_AWIF��*0q.8��*��N�HI���y=��̝��x��~\,d-y4���}W\�G�ݩ=���
�S���O�15����f�����ƫԬ�]N����C��h���Ć�O�5)��W�Z=��e/q,�9�O�������ef��T�
�6�j���f(͆�1�A_��m _;�Z}ѡ�
Ǝ#�'�'�p��� -�[c<�&���^i�~`�8�����7r.ϗ$Ԍ3�dP44I��q��"Ȧw ����<�yz~\Z4qٞv\�� ��^�l0;�7��7E�F7	����Mo��
�C�[U��6Zam�Eh���9��
@�K j���;��h`2�0�����\�zzJ��o��+jJ�w��NX�u���;$��G ܉���.:��Q�>��8ǺN5�d�cVv��$��߻�����lf�
X��.�.��G�s�	v'.R��Co/.3R�A!1��V*�������˄ˢ@o�h6"�e�s����Q��7��aˈ�x�:���Q��
-S=¹	��1�.���b������M���`Z*�n|��=��X�7�C�If��DIȐkYn%7��"\O߭λ�l��N�W�C�Y3!�n7~�#9K4��f��V�X?��K Ƃ�Y�>6~�M$,�Ǽ�>d<�Ç� �{Ե x6�.�F
)o�$�q��Ͽ#�����+����FKQ���Op��2�m��9�o�79cE��5��x�ᙾ��Z�yYe/�*�5�,O��)�w��I�|1/��|̀4��=< ��B�yq��W��9�OQ�}��g\4Ҟ:|}��Ё�5UC��	-6���&��������6� �(tӃ��K��I�Z����_�>:yv����{.���Ջ��:y����'�8��O������������      �   @   x�3��L�4�м��"C�l�?2202�5 "CCs+cc+cK=cSs3K<R\1z\\\ ��~      �   Q   x�3��,N,����,�L�ɬ��K�4202�5 "CCs+cc+cK=cSs3Kt)+#=KSC3�?"^/�W� �"�      �      x��}]��Ƶ���W@��Q��@�/*Y��-Y���J�*�!�!4$A���[���}��}�<m��4���	{��n��n���8�7�$�	���>ힹg_�g_g�UqǺ����Y�Yua�U�W��/v�m^/�Ԛgu����UfU���tS[�n����e��҇�m�����n��UY��OK�rW囬�l뻬�WY����O��uf})~o}�V�>��ح����*K+�	`����2�6)��X�G��<<c8�׷�7��ۮ������������d�u���R�b�e�2�bn]���|�8Q�?]쮖���'Ѷ,f'����_6�m�����H��q�N0e�����~��6={�L7���(������@�_%!%��(���t| Ѓݪ�Y��)�� P@���Z����~���skV�6u�������$fI2���nU��F���bS�o
n���+W+`9P�z�:B��|c='4Hé�l�gaOAy�	[��9�����s���UHWU�h�-��y��H,@<g�]�|$0����x4u|;N�� ���[/�k�@lR�sx� �b�9Q�2�!.C$��iy�"K�o���xIҖ]Ҷ��?@[0oD@�B)�g�4b�'/����D�ٟ���V�|כ�ĉ.#�mY���s�ro]��k�Y�KTRa�*+�,v�.x�`~�����q���1�G>\�Zٻ�߃✘y�P��YI��oG~�����X��Z%Nf�Ys�i�^��Q2q�F�� ��Ë��dCs�\���K��Ժ�.���݋Y�"�y
�*��I�.s�,�UvCx������^��]���hS�Jm��m=,@e������{�ʹ�F�B�8+րE����m�kP�5>(�X�WחYYY�:ە���=�� &�8� Ή�N�e�j��v�R�� 6�.|�.c��ߏ_�����! �	]�t�,@a��%�8"�gL@v������f+ FvG(���͙5A�P@�"��T$���������؛� �2��!���i�ר��[G�����	��A��u
�g��UZ�pq��78���	�6��qU�!����Iq��=�.[G��m��B�� ����4(��_�l�n�u8v������'��k
�	P��&��p���$��r�h�b�Ӵ�����nb��_�M�^ި�B����,-WyV�W�M�A�l�p��ǫ�9��V8!+���>):��Z?�@ �<�#���	 ��� 69���2���>˪�~�XlF%�"<��[ko��@��d���)|<P(�G��b�X�f��ޥ���1t�	��,|ǁ��|�в�*w����v�xRd\ W��~���x���ɯ��V��-�6�Ӡ�"�1'�	c ���ۯm6.w��\�DԨ��+9}�N/W��]�)�!V	�5���WK4%����|�R*Xs�@1�-�Sv�=R�m1��$��d�<@,�\����2Hנ)�P���ǻ��TZ�f?�r�E@c�jU߿��z���?��n����f |J>��*�xd��Z���)L��]��$�0�����!�'r}�٫�NBt�~�1{Up��E0[�����m���V�cp���f�aD@:2�`��<��`�B��Hg$��7��L�d�(z� ��(̩�X:dR����&�+c9�)�zQܞ���g.���:��1���Yß������e��bn[
.h*b��#�x�I9�/�GJ
Dy(�Z��Gpgd�<����FV�p�a��p����o�Q�vo�@`-�`l�������>��<V(e`c1#e0E�����0��D�h���8��ښb��~��?�}Kg?��%�/fs���@�U<�B�nA"��NsT�HOI���8��V~�M����@Z27<��i[߀�W^g����h?�\	��98�eHn��%i,�5�CR_��^��q�����gj���3)�<���@���}��v���°����SϷ�"�h�0�Z���Kk���02�"�P6w�5HB�P��L���i$W�]�����Hd $/��*�@�z���z��4bJiq�^�[���-��Iq5�S׳�%~2�U���y�-@���K���5ђ
����e~u�Q(T�,���ͮy\
��ա�͇���ɛ?�\���By.��(�a�B�7���Y���H9�c~�� ŀ*5j�`[R�o�@\g5��(�)�i#VHi���r�-�����/PI&�}�$Sױ=7�C6�0Uȁ�)r��{z�N�s[�tS�"ї���eWH��U����u�j"�5ʁ��U�z�0,�9>��p�y��DX�'JbK�&G�7�d��E�+<�,+k��k|*�R�~&	խs�ɩ�Sۢ����i�5�L�)s��*R x�/���I[�=�YIO��oU�}�����0g��w���Y^>�����\����}�_T�W���Exq���O��Il�Ї���!��OO�3����O����w��ɿ{��;c���V����U�����w_y/������k���2��]�a�䕿x��W?={��u���c� N֯�����??��������&�K	��][�M#�ߘ|t�`[`j��(��7�,9��WGjD!���^���}��:�>	�jL0Ǝ�9��~�L �C�}T_�[�췂�gۧmP|Z��e�gGQvxⅿ]vꄮ�n`̔&4�D�$��Nj�؎10,Q��8,��d�)X������W�O������ �� ���o�>n��;���i^�v¼��&^/�{wFC�\�djm*��Z=�B��S	�- ��A��b`�܉��g'��T�!,��|m-ư=��w�e�e���r\`	d���8��.�������mG&yM���x��$R���D�x�;�</�&>P�k�θc�m�k�B: ��^���T鼛M)��c�w�p�{�L9O��G�F�5Px<�6�D<fC�ԙ�~��#�"����Y#���_}]�4���@����Ѣ[�ݺ��6w���S������������s������K�~�����N��Kb���><�4�ï����_��;��,��y�O�����O�?\����\|3��'�,���=���,�Rl����~�_3kA���#2��~b�px���kBR-.2g/y��;5�a�*��	�$�ď�wu�%ƺ���J��&�;���9��M���$�@��]c�����F�)�����ʼ�&����~d{A�x@�_,&����\f�mCWi��?���Y�^S��!Hl/
�d�����[�����F`�����VM��P,��~z���2x�O�����x�K���	�����-�kJ��cP`���!}� J<rD��	ݠ�?�]�_;��؀ry,��I�q�P�����{Ңx���l��ic��{h=�{\X`C��� L���b�ۦ���i�sH�4�Bi����bWR�
�P�un�Qz�̷����V~�G�$!�P.^< iŧ;LV�f��h@�t�w!7�X��,��Έ�OV�����|�q�Y��x��]n�����R'��+v+b������W80�+j�Ӥ�8�Z����(��`׷��v��s��t�����œ���ë�~WކO���������ǋ�W��.���g��~�a��]]�]`�$[Wbf�D�R�:�-�
��+u��*����l��M~�M����dTPԖ#��{���e,9si�%��X�|XƢh�m��������cx(�g=������˼hL.�2�p�b�W�fDg6��D��w t@��V���O��I�LRP;��7�����M�IC�i���+����U���/Ө�L=�J �N���j4L�ˌ��=�*�ckѧQ�jL�U
���Z��gq�b$N4	ݳ����uFf�lF!-VH��%h���]�u�K&h�L�����1k]5��h��B��a���&!��*5�o�f�G�x�X}��{.    �i�9�qB����5�Ή��4��A��Pf:-�#
�wZq$�:���Y&S׵��R6	}  ��*%���JˌD�O��{�DWP����֎�6#�S�su�r��Tc����M#5�.A��q����c�K�I����ٿ߅H����8��Q��3����|%fS�C`Z�d
w[�`ry���$ִ���>m�3��"���@^��ҹI�: �)�[Wt���,���69�Mr�ҦZp��ѫı'���t�y����������~`'Q�;�$IK;�d�����)�M��b�u�fE@���,Zt8K3���mQ@�~�㏆�Sj���'o�n����{�yj&��s���7'��k#���y�,�D��hH�N`�Q��$�5��_>�S�;�!6;���ē0��u�X�*��	d��'���4%ݿ��5=��Us����jd�@��,";q��s'�Ԡ`����p��s�O*Rp���������j.=*��~�8a8�X�8:*���y u�G�����M�;C����}	 <� )�L�%<d���VaP\[���)G��#�m��ݬ��edr�[[�u@��p����v�3E��Ac�v��}��.��]A&Qp���>7�o���%��r�[�w�w�Ac�:Қ ��cc?�8�<�8��=�J�z*N32��ѱ����O�n;�q��:k�-ǻ�ce�eZ�Uyr�Ii"��#�c)�9�$�(A�[`��p��2�eN�jp�ت�&�f�gع�>�bH���ӱ΃a��.����1���oA��l��kp�a>�'��v�N��o5�#k��Z����]�L��Lb�_��h�PС�%���h�����k1n��5��C����fH����XPD5�Ò(��h�c���^r��o4 #�0UW�q�37�DlG�K�aq5�:�l:�g�x��8/z���o3�	 x�|q��iK��-�hC��R�dJHV�I����'�##x#��$�� �	4��v��2��g,�Z�u����.	0$���?��>��*]�����irPud��9�;7%j*��
�!bz�؀��7��>d���ҲR�x�z�����í�"��;��Az��4>�K��`�#W��@A~�/����	.؉c�Z����Y�g�U+�0~�S��Wb|�w�z�yV�}�4:"d�hJ>��B�k��$���zR��f�J��.AD�G���ɩ���c�$�<�>�4�w�����Y5+�K,���[ҌX%b�uE�q��u���D�C۬ Q���$���x�%�E�
�%��������{Uf�nt�)��7�c���@e�0�����A"�����UAp�]�L���,��w�h�h��9�@���a0IŖV�QT�7��.C
�H�`a ?����\d��\k�[7�u,c�o����؏��L�\ҡK�����$�|����>ȍ�̙!C;Cg��!����g��.5�)������!JsY�K4��RӒBR���K,@Y��>�a�g�ư��-���랰�cbxS�n���r���	�A_�z�8^0I4o����`��t |,�L�F��6,RN^��T��.$~�i�ˢmp	�3�Ġ������ ��+/�%���71%����if�,\�C3�ܔO
�a@�3�V��q��n�9���@�B�p����&��M	���t��l5@�;v&I�&��}�7EW����)6�?<��9k�=������3��Q�i�A-�H�{��ٍZ�e�x���}���S�G�_;t��3�g3�Np��椈�r	�t�+�WB4B�. �bE�V��)��&���b�9���t����9n��y�۔H-e�F�j�÷�J��&s���i�������K<�f�಴yo�݊���5�s̖��eLb78١. �����w��K�A9�L46- ��Lg`��;���&H�C�p���9'Ư���^pҚ;G[ˣVNV�u�5L`ЙW�1?������e�D5[��yL��k��sO%�R^��.y���ll�/5��q�q�CҒ7)h��a��2��RS�,?��U΅kLzp��P{��+�H��RQ~��jm��w������6�c�v |B�j΂�+�m<*��=p��o�( �be���Um�s(� x<������
�k�t�]	+��v]�GS����j,�bXURb}�H��� \��Ҷ��VM%cm���� �cM\WsX�t�m<M��Z"��۩lA����<P �~E�I�����ۻ��aO#���fI����[��*v��A��8Wsq�A2$(J6���f�b�v|�ף:a�!˹�64�ߏ�Pdh
e�ѭ\7�%4O�s]Ql���X<�"gY���&Z�j�� B݂˧����;1>���
����d���Nb��~����D��m�:Ƽ��/<���»&�9�ʚ;�l.�L���3��S뿹�8��O�'�J��}�K����x�e��%An�f��c��Ͻl�k��l�d	@;��:��<k�a
��R��y^��8>�=݉Ǿ(Z�-�<�`�||z����l���|��3J�|��b������{�7�E_s/�����F�t���}!�q�.��5�,��ZXܔ�1l�����]���|�)\����?v� AhC%���
hBi����n�vJ�̰���<���w�/jje��[;j0,�g�&78A���s��۬�h<�8.� �P�f(�����RЁY�`�x�k��q�H]h�k[��9�!j����e��G6Z���]1D�K�����"�}&?��>pE��!�n�X�*�׵�������2�%A��S3�h��j�K|��^��&3z9����N=d�Q�t����r������ڱç򰩘�4���?r.���>���1[ �]�܌F�'�z;��sF�J����w
U)��X��p�C9F?KW���C
{�	v�S�u������)�&$�]iI��=f��f�uȇv té�7�$A�*��jCk$����+ʺ,i�5sm,O�Th���ۃI�Es���aT�� 0�Į��t:؝�:#�MZ"t���V|�)y��6G5�=�C��CKw��QѠ�v=09�\l"�zn��w���-�77��0����6�}���A}h~t�9�`Z^b�ԡ;�t�E�#o�p��+���L�P̽Y����;�,D�N8.���I��Z�a��hZ��ƊN���c�[ͷ#^�eZ��9־G��s�b��ԗ@	 /�|�E+{����h�"��*��o�x!�6=D>�N+���yP�»��5Y���B�6�(�3ȧ8�'�R�(�w"�p��c���F82?�Pg<�`���BI�Yo������"��[}�4�n^`�/��1�S[�|�]�����^M��NW��:�.��������fA�(��uK�I/���08�|�z���/�8<��������I;ջ,�� ���>.p=ͩq���ETцA��o������@kT�I/��T�@���n���@l�!�l$`Ʀ?�:I���`�(!`����偯�X�[�Ӡ��a�b�<�T��>��x�}.4�zkF�.�i4��)>8G��f�^pU���ء��^ �i~���MG���/ܗ�7�d1�
�o��e�X�.���x9��c4X�.f������úAWc����3Rm����/R1w�lҮh��rq4��9�W��u�yZ8��[���k!�b�A��*��y*�Z=4p@�neď^���[4u&�t��O���m�S���j��)j����^�bx��@����ѱ�c-:�]�B�l�ȇ���#hM� ��^x�mZ΍sq��z�d�>����7��6Wr�EV`M�$v�"��b�;��} 갰Ew���I��*�f�hVb�$�˨�.�w�=W�2�H���� 4�θb��2w�#���k�͠ v>3P�7S��r�2��k���b�P�5pl�y!Vo|}�sg��� �  ��!x��>X�~�B�3#�e7�jה{�t��J� /V2 ���MPV}�C��&3�Wה$���۝��д�����V̝�P�k?�N$�Z#��i'��(�h�:�`0Fq���������˄�4a`(�1D%�1\���bt�O�2���t�4�=�E5`�%�0J��|���#�m�F�S�j�qt����*�7+�W�����f)n-�	�؎B����U-�Q�~�S�s�Ӎ2�MBP�j��$��ml��m8��%1R,��w�vfhr>8S���`�2�����_���O
����14b��n�{l��\�k���_є�N�����p7�V�#���\f�29����w���P��>�m��ym~	C�l~������/��gњ���ԝK|�3GҺ1|��蒟=���H��+�j�n5���<r&�b���B%��X�ݲXW���������1�oDt޾���T�-�L{�/&�;�V�|��E9�j�e74�s��>���� ��1\��x����Y��S��6a�I�1�9�9�Q��[>�c��p�޸���Ovs����x���E�Ձ��\l͸��E�ex���'ַO�L�r��z�{h;�q ��z��t���	�_������>^�x}p�S�'�>y5�P��_�6�.q�־<W�G�?��/!��N�q�a��CG���q
����R�{[	�szj�8컊���:.����l��qp�\GQë����@�e1���O��z�PL]���b��p�d�(�hE�g�1���Đ�i t��������.т��1HU����',���4j1���R91&�Al�zR��?�wԎ��ڌ��[;�0����� �t�i���Th$�/�4����3s%���5rY��I��� (A���6�يS�(��x�io���-��$D��� ?��P^��y&�J�� ,ϢR���T̉&k�S(p #���)��Ҭ��Bp�!P뵲V�5�e��._7`�G[X���P�R\�!t����sC�㟎���۟/���9����N��Sq�b�Th���nG�؞���Օ�{�� �(�.o�}���[�B����EH�h�:��h@�s_iޟpk�bxVC�	f��P	�D`�3ϡ�D�Ec:{mv-�l���8ƺ���6i��,�73��f�}-�3a����F�s�˟��Q�$�LV�V�(�ak� ���;Ħ[���ب����{ >0��!��O.�^�c<g:� װ8T�������n 2C?B�{]L�^��Q��:.u��tȢ{W�Rx��G#)��Q~o����\�>�歆|�){+��#R2���7W���4�-M׊눱���ɷM��c�Y>�+����x�`�Ǩ�w�����wb��9-�t�C'	[~qw܅�%�Ջ܍�V�ٮ ��o:q�%�H�Z�GS^�?6�M���n��(ԫ�W���Ns�X���H�<Q~kаܞ����Đg��K���V�1$2�«�j!Z�bU�Նl�f���P���nE�����S���s>i���#���Hq���&�X
*5xP�I�|+]`g#��9�����������0͌�@���gTWOy�?b��}�Z��B�D|O���[��XP�{��%���y��wL��lGD'XC+�?c'�]
�����(��Ҕ�T���!T�~۵��,G�ή{}4����æ��k��Z(㹶���E�h�z��*��9�Q�0�>��H4wE�v扩wch-�Mჿ�k��D�h�`�4�-��	��p#-V1��nV&��P��ef�!��
�s��8}��&K�˽V�1�(Ɯ,��W�f�]�s�y:�#�s���K�^�N}��&U4{BϹ'T&�mJ�Ti�Z����>�!V�Y�I Hjq�HE��u����pM���":�^e���t��%�8kMbQ�2#(���C��X�� �MV|yn[<W���m���:���bX���� �]��Rk!�x��h�mJ�U2N���sG&���T3���.��#�B��vT�<�D%��?���w��݂m���ow�l���MoZ毪��g1�y$��0B�D+t@Wb-,����"	�(P�Z8T:�v���P��Rb" ?F8����{��e鼹Q���E��[������������T�4�F�ݐ1�l��0�튃y�teՉñ�Y#�^65��8=�!������߿��CKG/���D-��M�/��-x� Pn��}����ʢl�9j�����7z>U�c-��`���S6���n�;��D�\�f>�0ώ#?bhb��B�q��8���.�; ߐߦ0��i9���D�er�Ln<��N�Ӄ#�Zo�"]gSGVp;�ȵ�� �o��/^���9���O����sޞ�>B�Q��ݐ��-W�<]�WrE��o���F��^A`��`���q*�q�ވ}�Ϩ�����5%=�"k^��r��I�Nͭ���z�E3�C��r�	�c� Ľ$J�b*
_`QB2Ka���;l׸L!ƥZ����F���67�G"p���+��V����:(��i�S��a�C�e��Xo��}nU^��䋗�L��D84�����ѥ/V��������'(�|��+��̟�a�R=�*�&�ƘfJ�����^�8���Ӷ˘$U��ufj=5/jpI�_���\��/$$���?�.�^��w�KL���X��yt�4�z��>�������?����<g�ݟC_j����/W�B�M���oe���������'����7��W R2u�DH����x �;��r�i�%�<�3�7�M|�񊐟�Ǌbt���S��/;<�7�:�ԧ��"�Lp���Q�G^o,��g��E�J���?��h�I䜭��dl3��'8a���6-ߦR�x�lY?f�J ���#%�����1�8�)����/����t��5}�jtۉ�#��	�r�\��Z�;:�Xl'��� ����7d�$9E�9�J�\U�S$��۷�'�h�-��R�;�X5����sU�n�F�x���Ĝ�K�)���.��\��~����u 2�xe۽:���Á�j�|<M�h�
:�����
�����8$�_�	�+�a �pm-�/��v���,����G�54?�����{����J�{@S��ҵW�:'{�	�1�q
e4�)�N�un7��&���ݣ<��&qn�FM�e��U�+A�'cl�%Zy�]^�������(q迸������J� �U�\:�y��U�	�v��z�n���l4J��Z\b�^D+�|N����k?���;���p+�G�s?�*۱2�����j��A�8���N��/r]���;�3����}a�A�^�����_z4k��ѫ��َC�?�8Lm�q-��`� ���A��E�hy&�}��'m�H������;x���n0J�	%jGm-���=�CGq���`�����f�0S�s���2L~���
�gcK$J&�q�?�:����=^k~Iu��e�����i��&��!����N�!`鞄���?ёK����j�V�af|����9,4hd/ŀƽf��7퍀���n�1�����z[�~G�g�1�}f����Hds������r��� �r��	��v���z�&$�r+���_��6��>�8�oY�a�9�Xk݊neP�WD]XW�X�|���Uݞ:q�l[�9$T.��x�Aգ:�:_�.���m������K|?�5���P���2�����t\&�}��T�X�9aM��B�Eт<�Ž9��l���e��2�b�k��'Wb�-nE+����d���i��֍7�ى炶L�bO&��A�?      �      x�3�L/(�5������ �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �     x�͏�J�@E�'_�h8g2�̛5TT�K�BIBn5ij.��{#j-}��b�}�$(ȮM�r�Iҭ�����y��)_g,����&5�a�7�b���T7�n������e� �@��a�T;J#��D����%=M�f��HW8��Ba1��(��٨b�(��-=.oq�eo&J��2��F13�ޮR���1>���a<g�R�8�l�P��p�@���Rb�R��� &եB���ց�i;.P�/;�ؖe} �@�       �     x�}��n�@���8��H��Ĺ�h�E%ԨB�����(�k.	�U}��O�'�̸��<�������`�۫���ٲ[���XR�j����*��QXWe��v�6p�>e�e�f{s�&��}���h�#'v��N��7;�\;���[�wPK} �����c��y�i���")�k�KGoF��b�/�����W���Z�/���^U��R_h0� �E;���X���(������d��fiN����Ifl��S�.�A�:}@S{�@�����D�CÝд�q����R�8q�b^<B��҉�u`��^n���!�T���B
��ԍ(Ow?_����!M�M��O�qI9G@���v��������xQqUF������M�^��y���8K'Ŵ�-�s�̟ ��BVh�H�>�Y
Un���t?���H���m�e01��m��"{4�����(�9�He�;Jǈ,�>;�ЧjC�'#���Ӆ�����a��b#�pǳ ���4��q�7��W��4I�ߓ^!9      �      x��]isו�,��k�Dz@Q"��e�N�$�bgR�r�Tx �ltý�F~��s�[�r<���+�$���-w9�.��_�~�׺���d�����$˳Ǽ�dy�ȶ�i�*��&3��z�1��d��~��Y�5ygVE�e��}~��L޴Y���O�ja*<�6嶨VY]�Ee�Y�⏶5m����L3��Ճ����,t(�`�]���M���M^�ٗ]���u����
�ʺ:3�jݝ.�U���ݻl�`ڭ��d�p_�+�
��aE�W�����$3�mޭMW�'��z>�[���e='Z�5ٺ�������JF_�y��0.1��&�u�l��1%'���N��]�����N1��}ǁ�&|��DL��<�������6����WkZ��_�e_f������l��s���=Z��ǰXؼo��o��)g�����ϸ�����|n�"lǶ)69�X�~0�x0vo��^���Xż�>�D&�nͼX���E��|�'νl�l�av���U;��TY�̊.k̏}ј����4����%ŭ�'�u���9g?���6�w%v��G��7|��p>��`�n[W8zs���2j�4�4y�%b�]����?��.�`�n��2?u��Y_uE)?��7CP±K8$hK������fwKyP�g6E˅L0t�S�p��ry���b.���.���+��ʋ���u����{�bRfa|�w����|�q��K=	��Z�9C̱,;���y���㢿�����d`���z�ϹW;�Ekʥ�t�,�jX���DՏ|
���u�?x_ۗ��i����5��ע<�C��Gxf�U��:��,d���ъ�~��Dg��X5b�&�2%�1���/��,N��|α��l<)Q�����2��>T|��[t����ug�ڶŦ���Ϯ�ɷ�OZ��`�d�k��B kܵ�1ƯV��[�?L{b��>���J���H+����hp����.��XX�\�%�����V����L$F��-�>o{J7V!�.�{�}��(U��-��7G����Z�T�E�Bͤ�����N����j^����?Њ���E�D�9��`8�\l0����Fg�m=9��3cʲ��c�'8�N�zxIY��԰1ق��#�v����!��2�ÐG9�'幭^a�%�mx���vA}��?�&�9�2���<�A5nKӈ#���{�<��U	�,c�e�
�d�G_ڿQq��Tv̲�7�&���p�������L�q��G�o�])h
 ]n9�;�j��N'�o1ؼ���Y��=�Q�y�j�ĆƎ�����4� j��n�{c�F��3���Kz�<SﺥI�: `J_. �nZ���4���y��`d7u6s�wK5������3�4��^��y�d v}����2Ш���[�HnW�4"�/�L<�,L�%��'\�N�k(�گu���u�͡:��!č��^�bb%�J�q���:&�������|���@q����C],n#��G�зy�;���>�ԳM�ރ�K�2h���?��J.�%��)�{��;0�X|g���(bi��cW_��=��]�-<�-��p��/��Qt��[5	Ѓz>�eO �t����k�m}f+��,�%U\��bkZ�(H	Wf�l]�A�����7�j���^��זo��cEH(r��j�9�8�̶pK
�����[�NA�7"¼��u��-��b��������=������x==�<?����9=?���n/�o/Χ7�o߼~����Ő�T��*:�]+���Z�o��8Ļ�m,�8J$������QM,��u��}3`&Q��t���?�������'g<K�� �u�����6寸����f_�����MA=�j�69�Pn�v��^]D*�]�S1՜[~�|��ʙ��f�V�ߠ���F(����<�iM�J���>� �&���QU���$븘�ɩ�C �� ����s��}_]N!{|`�!���7O4�r�<���M�-��yIoߨ�):�a����g�e�Q�zJ��:��%�A/�I�H���}�i��O��19ʎ�@,���W�8:�	$�G�p�����;�F��4�O�5�����^�~S������6��z��`Zj%�[D�F��"01
b��_�Z�v���0g�Z#*yy��z��rs��vNsF�'�u��"�7�$l�c���H6	�d��Og�=E$�]��!��ʄ#X:��'Z�������XF#hS
�� c��蛞+'�!8�������1=I�.I���aš:�q�ny�W��Ǖk��/�Ds	��C��>�.���~�FL=��H"�Q�`�o��� B� /��w���M �s��{~ӊ��ݾ�㇌���s�8i�`~��h��~k��ň��%l;����į�k:?�IU(4�_B�EH9�C�F�'�P���ɡ��^w�R�o-�`�������|G�G"އR"��9�����&�ӤG�S?_+��o�p�u�u��r�:�exv"$3a�����}�ċ=PywC˄-��S9��QM��r+��x�g�m����J���M~o��W`6�%܉���s�^"E�tà45i"It�}"����"NG�DK[Q�S���	�`�P�z�V��:R� ��\��SVse�k�p���[D���^���<J�C�����^5�v]�a&4n@o S�P��>�&��	_�;88�nm���=F�݇=m�J%��J��ؘ�r���波���C��Pb�$�&_�A�����d�iE�,���;�J��d��b��,�y�5�9���N�w�K%�|Q�`�J	�?�e��.��κ��=?8�kG�N����oŖ�
`-%%�bH�������pܐU �ސ�55P(g�H��q��J���P��-��s�B3̳ X�4�!�I��W��˖a�(�E��m待�01�R+��OF́z�!�[�0�H��Xȁ�m �c�n�0�I+`s]C[m"I�-�����`�9VbY�fʦI�I�0
��#}���GW�go^_��zq���| ����a�����}$)_+\�Q����Nt�p���h^Rt���,�ϛ�$؇gd� �N7i�mJu�_)�!���"�.���S񌣎:j�,�5�p��	J�}M�P,̐�I/_��)M
`��)�I
��W�O)�I钍��|k��fN�m4�~`Hχc.V�D��Yq���wNU6 �����"��D'�0�Z���O2�,b�X`�!��!*��>70_�\#�Ñ��d��ᄈX�P�m��#�n|1.�/��[0@@����L>qᙘg���;�*g�G�n?v�!]3`z���K�yE;h��T��Hzg@1u9�f��<R� �?�s#bA|�/X�6�;D�Nk�C!�J��S��`���4�u�5*KH����*��s Q*���e%�|�]�c���/�>�FX��c�f�[�`V1�3�6��~�֘F�x�m)�%4�Hܩ�_0̧Ǘ�E9�'
��h_O��?���؊î���ӈTf~O#��K(�Js��آ��jY�e.Q�l����fܪ�Ľ.��·"��x�8�MO_x˷�����T3?z���ĠST��s��,a0�k.���F�("���3ȣ(V��X0 ]���;e�m�O)r��cq�nڲ�ffw��]u;�[L���r�JHs��(�Gl%s������eyZI�U��������$�Pzϡ�d�Ifg�8,rh
��8��H�����\|�;�3��,��H�'H�g��%��ꨔ����e�ZU%�W��}��M�`�c�S_T�z<2�bk��gNA���Ŀ�}-$�A��D���a���5
��4(A-���lG��H��pae�'3�6Cḳ��mMW��k��A�P)
Q�����u�Y�`�}�~�M=e�O���p.���X�������i��6˝��1�m.#�����@8�+�]�X�T����޻i
{2�9�˱.'idN��U�i��V�-4��m�'
`�zl�
���IU�x?���>�    �]��^]L��ח//_\>�Yg��R��*5�9ա�Xe��{IӘ���3�
�v���8XD�5U�5��^E�^NB<�s�0#R�$�����{��d��3��U� ��0�'�bpcW���F�M7�kn��87kӪN/F���"غ;�P,6L��T+�ԁ���ʿ��>S���l*#�9��#ʦHs���2q*+�R�\�6�*Dȗ-�&�B�.@�'�(��&ac��P�B�����j:!k�+�>�癝�iK%�n��]�ͺu�ɅK%��O.�ί$O5�	�'�� 2���.�k�h�kT��3��Z�C�fM_��6&�L^(�S� ��uw���ʎ|���{��M�[�e�pFȫN��)~r\���rj�<�]ȱns)��h^�ّbiy��ݧ���;�6���Fv������.p1iٌ�~�ǆ��l�z�q�`d�}�\c�����%e5���'�fiu��J��`��Ƨ]dS7,�f-�^���&D�ISs�P�=T�&YU�׶���uS��Lm�SU�	yo��c�	5�LH`��Fj�}^T��܆����7�4�s[��᧜�ƒ;�_�^�0�b�]y��[I�.�>q'�.�$$�4�H('I�W�-���i>=zv��r$�
��s.��vH�~�N��b �`�A�̙��{�\�A���/���N��)9�8���ݧ8�����!�o���ڼ1.t��L%ڿP�r�m�v���M�N���R1�� ��NxN�U�T�����Z���v��J �р�aO�����hi?�:�s/�H��O��>#��u8o����u��"��a�L%�$�s-�4��|ж.�`mZh<�������|������������Lc�&g�D�̲��Q�Մ�,ia@ag𚝫ܴ}�Λb&{]Ύ@!���@̢c��^h�����H,�����=UW�i+��j4�/�
ЅR��Y�3s�@�ՠ�nv�(�:��)z���KO#��	!��m7�uB��a�X
2
��D�"�>P�6	�nP�6��
h�`�	�+\���N~w�]]dw��E.����%A�Ż5\Ǫ��d��̽���8��d��骩I�&E1Y �ki�a�5�̌빒�=̭d��U��ol�Ĥ�zѪW{fQ_BҒ�;a�qq_��K�I�t��(ʔW� ��e��ƨ��*�9Ь���-���W6�	up�Ҟ�o���PT��ESzp��<)[3�_�W��i���dN$[�S׋S����{�`��T��ڶ�T�=q��s=�@k�c&�J����JHV����fjٗT�]p�X:S�V���b���ANb��ʛ�2�;H����ej<��>gJ�\-[8����	5�h�/2�*i2`[I��ԕ�Qv�uʺ�'Ӱ`NZ���L�-Ɍi���}�P�X\��MZZ��<���ms2n2m�sh������ǀ���?(�e�ƃ��A�p�E�}8�9��3�%��{�pd�'U�
�b*F�)m4�yB)��QO_��H
D����Hu�	L�E���w	C�-gQ�����$�,'՘ �`:,�����F�z�tW� ����H��{��x�B����+��u�*���kl!0=�f&N���Y���cVkM='�yV�N!`4G|�t���9���ɸnR��En�T8T���U�Eu��� 2�7�pL�q\A�b���-�ӑ�P�nSD�e9�"�;W=���fL�x�Z��!��lz~su����͋�g���F���c�E�\�e�mY4W�f��%'�qWW�N�CWW���Y���P ^l�����H�5E=�{��TMd�s:�$�!���9̉̓�a����f��=,�@��k�I�y�Gc�9�6���᧔�q�t4��i��4O���$r:�S%�x�õ�`g��:G�����#���t��ۋ��: �Rc�ǫA��'�!�U�����!H�qnp�S�¯~��9z&�-�j(��eUIǔaH��K�&�����������H�YWh3��u��L<�R�΢d��E����}(�(�o�b�iۍr�ب'�k��$�?;\i@L�}Ҷ���U����f�рdkϨ�%·�y�j�:1~|��HY�0N���6F�����6���æ��*�:��m�;<��qLd�E)1i��
�I%X���x�C���cЗ$9:&M�~�w��d��T�r{,�[#CY��vR�q=[1P	�f��U�-;im�Adyо����n�!��>j�ǂ� �oA��*+��(Yy^�� �$�m��I����a��{�K������~�Wm=J@9�q��wP)�Nѽ3��Q�*�����ڟ�{q}��z����������o_�7LÖ��.��0�ev~s�����|z~����r�ћ������7W/߾x{Y�z;NY�{�b�����[)g~�������H�d�С�Y�t�����A�;�O�7�7�b`{�Icht��n��U�؉��ײvh��t�����ȕ��;����*��2�l���MJ�m�d��p-{L�t���y�~C�fў�uN�bT�i�8aӌ�ŉ���8��x6o�.�V�B���tu�Ew9$U�I���dE*��=|�MZ�Lp!+�m)+�[�����-|z4�&^mi|�V��]呂[��8���4�|�O�T�򚷛ȉ���jw�ɝ�d'G�d�	�y|��
��Q[E�q'N\a���#�4�r��ۊ�]���D�Չ�5���˺B_F�tPֿ5�.�
�n�t����sbYZZ[���'�}�Llu�����~keu[��ióf��~�FA�;�6��$c���V[+�y��R�̮fE�&���aϽ���<�߸n��׫)��8���뜗u�Ul��#R��%�fWgg�f�@戒>^���f�p��Z�pW���Θ��g�i�0;:e۶��r�C�;�=��"� �
Ou܏bW�q6i��_���� �z��\�tXq��/z�}�
5���kM+�j_O�-�K$>��_x��)�<IJ�
?��5p���������ϊP�fS���~�-��U��9����aV��:���G��Uژ�ZҜ"������G��f�!�q�	L*]����t���N�_]j-�z{�AK%��_Տ�Z=u	"jQ�~>=:�rJ��Jt=�rec�uI��!3��D�(Ơ��ކ��`����������|t+������Se!Q믿ݩ,]�I�ڍ����}�:xH	�����%9�nّٳ]c�pӬ� 	�r�9�Da�1y�D�NR�˝Hm����dǿ{�t��T��t	ϑ�{�)E�87Ri�w�����u�k|dC3X�g.�-�+I5@�bslXv�+�m�.�x�y/p�̅xUa��Mz^��%'а%�a"�'�m�_<eks�]д��͌7F"��]KET�8�(o�Wi����Q10�ۊi��z|�;)B�U�k�"��`�)��P��"<?�q|�Un����r��^����)ω��ݻ�8p���X�@�����6�H_{Q[�Mw�Aj1C��L��b��J<��Z�򡴰l�lp���}�@��^)��m푋p;r���b�w���j_��O��fG/��({��(��afJ8�+)��|�����w��;�aU鮎8���d��V*�whv7�~:"O�5U�wuM����n�Z.y�B�ñ��_��6v��q��mT��}9��pI��r/{����W��4�a�&��֬���x���Q�5E��qz1��6�� w2�w�.�Dj�I�]��z��.�ǲ�D��x�K޻^��k㏝!/a(4>����. �u���]�_��WӍ^�eoz�dۛw�'������2���U^9��t��`�m�w|�7#ɕ~��o��l��{9�Aᐚ��_��n���G�C�i���!	�'ڊW�}T#�����󫋛��g/���ZZg�~fn(���P�����.��V���?S�{As��TW����f���1�T[��~A��\�ӔR��Ll�FB��x�3ӁzI��2���|�7�z�o':Ȣ]� _  �T|p��,�գ	�nd��O2�ư�e��[�M�)�Tξ|��g�W�?滣���F���.�xa��Hv�'�~�������Z�$�0b�|�k�:�a��S���;~��g��w���	$��'\�G��ܒ�_#
![������I.����+���k�C�hȯ}'��j��nw�����6?���Ɔsx3�{FC"��D����TESW�D(5�ɝ�БE*O�ڹ�H+����)�`���(?����o�BO�4��~�������u�`�:-�p�W����dcڱ�p�t0�����"�qzo[uC�n����=�@�cw��]p�.xs{�zzvy�����ӗ/_�7�Id�      �   �	  x��[o�ǟ�OQ�"��ۘ����b� ^�H�&�Cuw�L��UMW��Χ��9՗��8kHpT0s�T���LM�&��F�Z	)�z�,ZQ�6W�ikd!��D^ke2|3#��i�oEj�k
/�?�R�����ʄ6�U֤^��Ȕ��P��=��J�t�&�މ�֢V�˦�:aWF�nvi.�V�>��u+l�O��Jh'��]��R[�BL��
b|�\��1��r:��~�v�IE�(�4B]+#t.����FC������R����V�Z:�i��@%Fr煬u��W�r�(�&�eU(χWp�rAg��U��U���Vp Lq2��4?\�?_|���0�N4�������j�0�nB,+Ud�c�[��,>#�R;�� �m��]������N�?�B{E����HC&��R�?:�Ke*#�׸�է� �ղš:D��Dd ��!�`1� g�(-Hŏ�$y�L<����*d��A3���m)N*�C^�x�7@2W�vpTS&0�b&�B����J���8�Ҿ��7j&�mSd$#Ȼ�DА�\�^>\�_��-Q<@� J�[��/�ݼ9���3��y��J�
Z�e
]�&�<���["z�
�k�s ����n�z&
��Ƌ���׿�#\z��)�.U��Q6vE9rr�����p��|C�E]�߾e��S��$>�����^���
������!�_0.YJ[Y*� �6���A9J�pxaS�g���-^"l��J%�Hau�zb�iDu�#?ٕ(��qL�C�2	4u��ȓΗd�1��>�x$.�|6��)_�3�s��r���I�4oj�j���8G4_���sd�-!2Oю`6��ܺM�?n�"sٓh��Ă2�0�)�TR�@;�Ҝ����/%�*�e�����u��T}�ޟW(�O\?$��b�+:�x��O��kj�f\���bJֲ1:���6�g��V�b_*�z�2>ы]îy7��û*��%$�S��k��+���8�xk[Y�v�DW
N-����K��䷹�,C��7��#i�5%�V}�Z�W���BsԣIǒ��*kx��Ǌp9�ƋZ����s��zʹ4��)�y�.�N���w��R^�W�5��B���P<�'�~4od���/�r�Fd:gc<�0Q.�2��Fg���8��My�9Ƥ�ʯ��/Vk�����Z"+@�V�=ϼ.Y.�3�����H��]��d\�*�c������Б�P47��S���/��|���P�O Μ����ԩ��jQsSs�NE\PY|��_�C2�9�Xޡ�u�t� �*��<$vQc0�>o�5
ù)a�*)3IB���u�%���Gf��D�;,ɽE��R\$��bx�.➦UO�#��Yƍ8ikO�7-4{��}����B����+a�#";t�Jt|�k���9�H�a�-]J���]���]�O��`D��G�*
Ȋ"���8϶�#5� �PL���qQە_"�> �s67Crp�S�6̰��$?E�ʚ�f^��tڑr��0E����L��m��-0Rg:5v���������O��X���������9G�g'�g�OgG'GO����W�'��Ȯ�k��}��k��q�{Wܻ��{�v5n�~�V,�S�����n�����F���ANn|�ݎg�}�~��5����ޅ�p��;-x�ed�ݦ��7�y������۝ �j%K�w1�oճ�(t�xﻖ��� +ז�t{��{{�A�=�FP!n	�p�݌r�Z"G��!����*�"Z4xg{��v#9��(oK�$ŸO��B��ڊ���p�n��ξ�@Txbe���)~Um��w���o}�S�y��n�a��w�$�lT���%��"��1�HD{����T3�t��Y�	-d�����Ă$�v��JO`y(����m���^�ț�ʝ���1 ��jI�Zc#S.�u2�:o�t��$�]d�݁�&scG�	-CŲ�{1̼*�4"�-n��m���~�F��� �f5g��6ѭG]�TYS���w��+�қ��U
Y_����L�p���]�7���f1�{
-�3qG�;�}�QO&'���+�q���緸2��J_`��v�Oٵ�S���BA?������{�6�ۿz��G�l�0dc����������.������ݍ�w������{����ٿ��,i�l���f�a	Ϭ�����R�M�=v����;����5Ͽ���?��-)ky��X��1U�[{p�n����V�w��[
�S�W)cǊ/]"��������h#�F��@�6m��h�/ОNN#�F��@�6m��h#�F���@�l�,m��h#�F��@�6m����O��@�6m��h#�F��@��������h#�F��@�6m��h�/о���@�6m��h#�F��@����ѓ	�D��H�6"mDڈ�i#�F��H{o��r����� �`��      �   �  x��RMo�0=˿�? ,;A>n-�a���.�L;�l)������4�v0
�E?���ب#2�U�`�tY�"/�O�<%��~U�K���f����ա�F����:
a
aօhc?���óu�5$!��]+�`|�A^L(�0�j��}Y��R�:�:<�uĆ&���SD�@WM�_w ���y���f:cE�su���_�s�Ή�\	�x�6ԑ�I����9�B
��֧x�S�fkhn�L���B�+��ѝ�����C�<�F}O�d�#������:�M�12RkF�Ӕr&�1u�l�^���?>��WQÃ�6��g���Lr�e�f���o���熜�M��`q�!]���0������p#��q�����:�z���[;4!a1&���Ҹ�,���#�RZ���"���ǯ��ﳪ��f|����,�� �H9�      �   r   x�3��,(J��,��M��H�KNM�LLT��)8��d�(���p�� �������������!H��hNRbqf2gF��Siqf^jq16}�V�fVF�z����\1z\\\ 6�#�      �   �   x�]��MAD��Qtc����3��p�F ��W.���v�ޤ���Z�r���"�����[�ү���t�V�(���ظ�Z����c����1۰-Ǯd���)�eң\�����Msz|�p�������b�X�y�������:'@�K��~��^�0#F����7�(<>      �      x������ � �      �      x������ � �      �      x������ � �      �   /   x�3�44�4�4202�50�54P04�26�26�323740����� �>�      �   �   x�M�MO�0��s�)8캾��DCA�S+����P�n�n�}{���9>��|7�����xW���e�j��i�x�����I���?�U��,.��$�n�v���I=��cs]��G�z�G,�|�!`0$w�n��T+[#)�A�hߌ�F��? e�R�n�ͱ��m&F�����OdZ%ݔpV�$oV�D��f��m�Ke�[u.��*	<F{"�E~�-	���b�q� ��OJ     